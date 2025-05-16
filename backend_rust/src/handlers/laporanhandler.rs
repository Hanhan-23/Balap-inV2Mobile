use std::sync::Arc;
use actix_multipart::Multipart;
use actix_web::{web, HttpResponse, Responder, HttpRequest};
use futures::{StreamExt, TryStreamExt};
use mongodb::bson::{doc};
use mongodb::bson::oid::ObjectId;
use crate::models::laporanmodel::{CardLaporan, DetailLaporan, Laporan, LaporanBaru};
use crate::mongorepo::MongoRepo;
use serde_json::json;
use crate::models::app_state::AppState;
use crate::utils::s3service::upload_photo;

pub async fn get_laporan(db: web::Data<MongoRepo>) -> impl Responder {
    let filter = doc! {"status": "selesai"};
    
    let cursor = db.laporan_collection.find(filter).await.expect("Failed to find documents");
    let docs = cursor.try_collect::<Vec<Laporan>>().await.expect("Failed to collect documents");

    HttpResponse::Ok().json(docs)
}

pub async fn get_card_laporan(db: web::Data<MongoRepo>) -> impl Responder {
    let projection = doc! {
        "_id": 1, 
        "gambar": 1,
        "jenis": 1,
        "judul": 1,
        "deskripsi": 1,
        "status": 1,
    };
    
    let options = mongodb::options::FindOptions::builder().projection(projection).build();
    
    let filter = doc! {"status": "selesai"};

    let cursor = db.card_laporan_collection.find(filter).with_options(options).await.expect("Failed to find documents");
    let docs = cursor.try_collect::<Vec<CardLaporan>>().await.expect("Failed to collect documents");
    
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

pub async fn buat_laporan(db: web::Data<MongoRepo>, laporan: web::Json<LaporanBaru>) -> impl Responder {
    match db.create_new_laporan(laporan.into_inner()).await {
        Ok(id) => HttpResponse::Ok().json(json!({ 
            "id": id ,
            "status": "success"
        })),
        Err(_) => HttpResponse::InternalServerError().json(json!({
            "status": "failed"
        }))
    }
}

pub async fn upload_gambar(state: web::Data<Arc<AppState>>, req: HttpRequest, mut payload: Multipart) -> impl Responder {
    if let Some(item) = payload.next().await {
        let mut field = item.unwrap();
        let mut data = Vec::new();
        
        while let Some(chunk) = field.next().await {
            data.extend_from_slice(&chunk.unwrap());
        }
        
        match upload_photo(data, req.clone(), state.clone()).await { 
            Ok(key) => HttpResponse::Ok().json(json!({
                "key": key
            })),
            Err(_) => HttpResponse::InternalServerError().json(json!({
                "status": "failed"
            }))
        }
    } else {
        HttpResponse::InternalServerError().json(json!({
            "status": "failed"
        }))
    }
}
