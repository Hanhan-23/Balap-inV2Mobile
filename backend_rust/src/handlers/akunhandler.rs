use actix_web::{web, HttpResponse, Responder};
use chrono::Utc;
use mongodb::bson::oid::ObjectId;
use crate::models::masyarakatmodel::Masyarakat;
use crate::mongorepo::MongoRepo;
use mongodb::bson::{DateTime as BsonDateTime};
use serde_json::json;
use uuid::Uuid;

pub async fn buat_akun_masyarakat(db: web::Data<MongoRepo>) -> impl Responder {
    let new_akun = Masyarakat {
        id: ObjectId::new(),
        tgl_pengguna: BsonDateTime::from_millis(Utc::now().timestamp_millis()),
        token: Uuid::new_v4().to_string(),
    };
    
    let result = db.masyarakat_collection.insert_one(&new_akun).await;
    
    match result {
        Ok(_) => HttpResponse::Ok().json(json!({
            "status": "success",
            "id": new_akun.id.to_string(),
            "token": new_akun.token.to_string(),
        })),
        Err(_) => HttpResponse::InternalServerError().json(json!({
            "status": "failed"
        })),
    }
}