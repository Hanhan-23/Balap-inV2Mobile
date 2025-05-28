use actix_web::{web, HttpResponse, Responder};
use futures::TryStreamExt;
use mongodb::bson::{doc};
use serde_json::json;
use crate::models::rekomendasimodel::{Rekomendasi, SortQuery};
use crate::mongorepo::MongoRepo;

pub async fn get_rekomendasi(db: web::Data<MongoRepo>) -> impl Responder{
    let cursor = db.rekomendasi_collection.find(doc! {}).await.expect("Failed to find rekomendasi");
    let docs = cursor.try_collect::<Vec<Rekomendasi>>().await.expect("Failed to collect rekomendasi");
    
    HttpResponse::Ok().json(docs)
}

pub async fn get_rekomendasi_card(db: web::Data<MongoRepo>, query: web::Query<SortQuery>) -> impl Responder{
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

    let order = query.sort.as_deref().unwrap_or("asc");
    println!("{}", order);
    if order == "asc" {
        result.sort_by(
            |a, b| {
                a["tingkat_urgent"]
                    .as_f64()
                    .partial_cmp(&b["tingkat_urgent"].as_f64())
                    .unwrap_or(std::cmp::Ordering::Equal)
            }
        )
    } else if order == "desc" {
        result.sort_by(
            |a, b| {
                b["tingkat_urgent"]
                    .as_f64()
                    .partial_cmp(&a["tingkat_urgent"].as_f64())
                    .unwrap_or(std::cmp::Ordering::Equal)
            }
        )
    }
    
    HttpResponse::Ok().json(result)
}