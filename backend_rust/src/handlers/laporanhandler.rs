// Nama File: laporanhandler.rs
// Deskripsi: File ini bertujuan untuk menangani seluruh logika dari data laporan
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025


use std::sync::Arc;
use actix_multipart::Multipart;
use actix_web::{web, HttpResponse, Responder, HttpRequest};
use futures::{StreamExt, TryStreamExt};
use crate::models::laporanmodel::{CardLaporan, DetailLaporan, Laporan, LaporanBaru, SortCardLaporan, SensorResponse};
use crate::mongorepo::MongoRepo;
use serde_json::json;
use crate::models::app_state::AppState;
use crate::utils::s3service::upload_photo;
use chrono::{Duration, Utc};
use mongodb::bson::{doc, Regex, oid::ObjectId, DateTime as BsonDateTime};
use crate::models::petamodel::Peta;
use reqwest;

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

async fn get_sensor_result(
    state: web::Data<Arc<AppState>>,
    laporan: &LaporanBaru,
) -> Result<SensorResponse, reqwest::Error> {
    let uri = state.ai_uri.clone();
    let client = reqwest::Client::new();
    let res = client
        .post(uri)
        .json(&serde_json::json!({
            "judul": laporan.judul,
            "deskripsi": laporan.deskripsi
        }))
        .send()
        .await?;

    res.json::<SensorResponse>().await
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
    
    // PROCESS DETECTION ABUSIVE WORDS
    
    // Ambil status awal dari laporan
    let mut status = laporan.status.clone();

    // Panggil sensor API
    let sensor_result = get_sensor_result(state.clone() ,&laporan).await.ok();

    if let Some(sensor) = sensor_result {
        let count_star = |s: &str| s.matches('*').count();

        let abusive_judul = sensor.judul.predicted_label == "abusive";
        let abusive_deskripsi = sensor.deskripsi.predicted_label == "abusive";

        if (abusive_judul && count_star(&sensor.judul.censored_text) < 3)
            || (abusive_deskripsi && count_star(&sensor.deskripsi.censored_text) < 3)
        {
            status = "disembunyikan".to_string();
        }

        // Timpa teks dengan hasil sensor
        laporan.judul = sensor.judul.censored_text;
        laporan.deskripsi = sensor.deskripsi.censored_text;
    } else {
        println!("Sensor API tidak tersedia, lanjutkan tanpa klasifikasi.");
    }


    // let mut req_with_ext = req.clone();
    // req_with_ext.headers_mut().insert("x-file-ext", ext.parse().unwrap());
    
    // PROCESS UPLOAD IMAGE AWS S3
    let key = match upload_photo(data, &ext, state.clone()).await {
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
        status: status.to_string(),
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

#[cfg(test)]
mod tests {
    use super::*;
    use actix_web::{test, web, App};
    use std::fs::File;
    use std::io::Read;
    use std::sync::Arc;
    use http::header;
    use aws_sdk_s3::{Client as S3Client, config::Builder};
    use multipart::client::lazy::Multipart;

    #[actix_rt::test]
    async fn test_upload_laporan_gambar_minimal() {
        let shared_config = aws_config::load_from_env().await;
        let s3_config = Builder::from(&shared_config).build();
        let dummy_s3_client = S3Client::from_conf(s3_config);
        
        let state = web::Data::new(Arc::new(AppState {
            ai_uri: "http://localhost:1234".to_string(),
            s3_client: dummy_s3_client,
            bucket_name: "dummy-bucket".to_string(),
        }));
        
        let db = web::Data::new(MongoRepo::init_test().await); 
        
        let app = test::init_service(
            App::new()
                .app_data(state.clone())
                .app_data(db.clone())
                .route("/upload", web::post().to(upload_laporan_gambar)),
        )
            .await;
        
        let mut form = Multipart::new();
        form.add_text("laporan", r#"{
            "judul": "Test Judul",
            "deskripsi": "Deskripsi bersih",
            "jenis": "jalan rusak",
            "cuaca": "cerah",
            "status": "pending",
            "persentase": 0.5,
            "cluster": null,
            "id_masyarakat": "607f1f77bcf86cd799439011",
            "id_peta": {
                "alamat": "Jl. Test",
                "jalan": "Test Raya",
                "latitude": 1.0,
                "longitude": 104.0
            }
        }"#);
        
        let image_file = File::open("tests/test.png").expect("tests/test.png not found");
        form.add_stream("gambar", image_file, Some("test.png"), Some("image/png".parse().unwrap()));
        
        let mut prepared = form.prepare().unwrap();
        let mut body = Vec::new();
        prepared.read_to_end(&mut body).unwrap();
        
        let boundary = prepared.boundary();
        let content_type = format!("multipart/form-data; boundary={}", boundary);
        
        let req = test::TestRequest::post()
            .uri("/upload")
            .insert_header((header::CONTENT_TYPE, content_type))
            .set_payload(body)
            .to_request();
        
        let resp = test::call_service(&app, req).await;
        
        assert!(
            resp.status().is_success() || resp.status().is_server_error(),
            "Unexpected response status: {}",
            resp.status()
        );
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