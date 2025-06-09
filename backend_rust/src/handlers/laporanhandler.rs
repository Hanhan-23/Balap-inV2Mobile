use std::sync::Arc;
use actix_multipart::Multipart;
use actix_web::{web, HttpResponse, Responder, HttpRequest};
use futures::{StreamExt, TryStreamExt};
use crate::models::laporanmodel::{CardLaporan, DetailLaporan, Laporan, LaporanBaru, SortCardLaporan};
use crate::mongorepo::MongoRepo;
use serde_json::json;
use crate::models::app_state::AppState;
use crate::utils::s3service::upload_photo;
use chrono::{Duration, Utc};
use mongodb::bson::{doc, Regex, oid::ObjectId, DateTime as BsonDateTime};
use crate::models::petamodel::Peta;

pub async fn get_laporan(db: web::Data<MongoRepo>) -> impl Responder {
    let filter = doc! {"status": "selesai"};

    let cursor = db.laporan_collection.find(filter).await.expect("Failed to find documents");
    let docs = cursor.try_collect::<Vec<Laporan>>().await.expect("Failed to collect documents");

    HttpResponse::Ok().json(docs)
}

pub async fn get_card_laporan(
    db: web::Data<MongoRepo>,
    query: web::Query<SortCardLaporan>,
) -> impl Responder {
    let mut filter = doc! {
        "status": "selesai"
    };
    
    if let Some(period) = query.period {
        let now = Utc::now();

        let start_time = match period {
            0 => Some(now - Duration::days(7)),  
            1 => Some(now - Duration::days(30)),    
            2 => Some(now - Duration::days(365)), 
            _ => None,                           
        };

        if let Some(start) = start_time {
            let start_bson = BsonDateTime::from_millis(start.timestamp_millis());
            filter.insert("tgl_lapor", doc! { "$gte": start_bson });
        }
    }
    
    if let Some(search_term) = &query.search {
        let regex = Regex {
            pattern: format!(".*{}.*", regex::escape(search_term)),
            options: "i".to_string(), 
        };

        filter.insert("$or", vec![
            doc! { "jenis": { "$regex": regex.clone() } },
            doc! { "judul": { "$regex": regex.clone() } },
            doc! { "deskripsi": { "$regex": regex.clone() } },
        ]);
    }

    let projection = doc! {
        "_id": 1,
        "gambar": 1,
        "jenis": 1,
        "judul": 1,
        "deskripsi": 1,
        "status": 1,
        "tgl_lapor": 1,
    };

    let cursor = db
        .card_laporan_collection
        .find(filter)
        .projection(projection)
        .sort(doc! { "tgl_lapor": -1 }) 
        .await
        .expect("Failed to find documents");

    let docs = cursor
        .try_collect::<Vec<CardLaporan>>()
        .await
        .expect("Failed to collect documents");

    HttpResponse::Ok().json(docs)
}

pub async fn get_detail_laporan(db: web::Data<MongoRepo>, oid: web::Path<String>) -> impl Responder {
    let projection = doc! {
        "id": 1,
        "gambar": 1,
        "jenis": 1,
        "judul": 1,
        "deskripsi": 1,
        "status": 1,
        "cuaca": 1,
        "tgl_lapor": 1,
        "id_peta": 1
    };

    let path = oid.into_inner();
    let obj_id = match ObjectId::parse_str(&path) {
        Ok(oid) => oid,
        Err(_) => return HttpResponse::BadRequest().body("Invalid ObjectId"),
    };

    let filter = doc! {"_id": obj_id};

    let cursor = db.detail_laporan_collection.find(filter).projection(projection).await.expect("Failed to find documents");
    let docs = cursor.try_collect::<Vec<DetailLaporan>>().await.expect("Failed to collect documents");

    HttpResponse::Ok().json(docs)
}

pub async fn upload_laporan_gambar(
    state: web::Data<Arc<AppState>>,
    db: web::Data<MongoRepo>,
    req: HttpRequest,
    mut payload: Multipart,
) -> impl Responder {
    let mut data = Vec::new();
    let mut laporan_baru: Option<LaporanBaru> = None;
    let mut file_ext: Option<String> = None;

    while let Some(item) = payload.next().await {
        let mut field = item.unwrap();
        let name = match field.name() {
            Some(n) => n.to_string(),
            None => return HttpResponse::BadRequest().body("Missing field name"),
        };

        if name == "laporan" {
            let mut json_bytes = Vec::new();
            while let Some(chunk) = field.next().await {
                json_bytes.extend_from_slice(&chunk.unwrap());
            }
            let parsed: Result<LaporanBaru, _> = serde_json::from_slice(&json_bytes);
            match parsed {
                Ok(lap) => laporan_baru = Some(lap),
                Err(e) => return HttpResponse::BadRequest().body(format!("Invalid JSON: {}", e)),
            }
        } else if name == "gambar" {
            if let Some(cd) = field.content_disposition() {
                if let Some(filename) = cd.get_filename() {
                    file_ext = filename.split('.').last().map(|s| s.to_lowercase());
                }
            }
            while let Some(chunk) = field.next().await {
                data.extend_from_slice(&chunk.unwrap());
            }
        }
    }

    let mut laporan = match laporan_baru {
        Some(l) => l,
        None => return HttpResponse::BadRequest().body("Missing laporan field"),
    };

    let ext = match file_ext.as_deref() {
        Some("jpg" | "jpeg" | "png") => file_ext.unwrap(),
        Some(other) => return HttpResponse::BadRequest().body(format!("Unsupported file type: {}", other)),
        None => return HttpResponse::BadRequest().body("Missing file extension"),
    };

    // let mut req_with_ext = req.clone();
    // req_with_ext.headers_mut().insert("x-file-ext", ext.parse().unwrap());

    let key = match upload_photo(data, &ext, state).await {
        Ok(k) => k,
        Err(_) => return HttpResponse::InternalServerError().body("Failed to upload image"),
    };

    let new_laporan = Laporan {
        id: ObjectId::new(),
        gambar: format!("https://balapin.s3.amazonaws.com/{}", key),
        judul: laporan.judul,
        jenis: laporan.jenis,
        deskripsi: laporan.deskripsi,
        cuaca: laporan.cuaca,
        persentase: laporan.persentase,
        status: laporan.status,
        tgl_lapor: BsonDateTime::from_millis(Utc::now().timestamp_millis()),
        cluster: laporan.cluster,
        id_masyarakat: laporan.id_masyarakat,
        id_peta: Peta {
            id: ObjectId::new(),
            alamat: laporan.id_peta.alamat,
            jalan: laporan.id_peta.jalan,
            latitude: laporan.id_peta.latitude,
            longitude: laporan.id_peta.longitude,
        },
    };

    let result = db.laporan_collection.insert_one(&new_laporan).await;

    match result {
        Ok(_) => HttpResponse::Ok().json(json!({
            "status": "success",
            "id": new_laporan.id,
            "gambar": new_laporan.gambar
        })),
        Err(_) => HttpResponse::InternalServerError().json(json!({
            "status": "failed"
        })),
    }
}


// pub async fn upload_gambar(state: web::Data<Arc<AppState>>, req: HttpRequest, mut payload: Multipart) -> impl Responder {
//     if let Some(item) = payload.next().await {
//         let mut field = item.unwrap();
//         let mut data = Vec::new();
//
//         while let Some(chunk) = field.next().await {
//             data.extend_from_slice(&chunk.unwrap());
//         }
//
//         match upload_photo(data, req.clone(), state.clone()).await {
//             Ok(key) => HttpResponse::Ok().json(json!({
//                 "key": format!("https://balapin.s3.amazonaws.com/{}", key),
//             })),
//             Err(_) => HttpResponse::InternalServerError().json(json!({
//                 "status": "failed upload image"
//             }))
//         }
//     } else {
//         HttpResponse::InternalServerError().json(json!({
//             "status": "failed upload image"
//         }))
//     }
// }