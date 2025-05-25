use actix_web::{web, HttpResponse, Responder};
use futures::TryStreamExt;
use mongodb::bson::{doc};
use serde_json::json;
use crate::models::rekomendasimodel::Rekomendasi;
use crate::mongorepo::MongoRepo;

pub async fn get_rekomendasi(db: web::Data<MongoRepo>) -> impl Responder{
    let cursor = db.rekomendasi_collection.find(doc! {}).await.expect("Failed to find rekomendasi");
    let docs = cursor.try_collect::<Vec<Rekomendasi>>().await.expect("Failed to collect rekomendasi");
    
    HttpResponse::Ok().json(docs)
}

pub async fn get_rekomendasi_card(db: web::Data<MongoRepo>) -> impl Responder{
    let cursor = db.rekomendasi_collection.find(doc! {}).await.expect("Failed to find rekomendasi");
    let docs = cursor.try_collect::<Vec<Rekomendasi>>().await.expect("Failed to collect rekomendasi");
    
    let mut result = Vec::new();
    
    for rekom in docs {
        if let Some(first_laporan_id) = rekom.id_laporan.get(0) {
            
            if let Ok(Some(laporan)) = db.laporan_card_rekomendasi
                .find_one(doc! { "_id": first_laporan_id })
                .await
            {
                result.push(json!({
                    "rekomendasi_id": rekom.id,
                    "status_urgent": rekom.status_urgent,
                    "tingkat_urgent": rekom.tingkat_urgent,
                    "status_rekom": rekom.status_rekom,
                    "id_laporan": laporan
                }));
            }
        }
    }
    
    HttpResponse::Ok().json(result)
}