use actix_web::{web, HttpResponse, Responder};
use futures::TryStreamExt;
use mongodb::bson::{doc};
use crate::models::rekomendasimodel::Rekomendasi;
use crate::mongorepo::MongoRepo;

pub async fn get_rekomendasi(db: web::Data<MongoRepo>) -> impl Responder{
    let cursor = db.rekomendasi_collection.find(doc! {}).await.expect("Failed to find rekomendasi");
    let docs = cursor.try_collect::<Vec<Rekomendasi>>().await.expect("Failed to collect rekomendasi");
    
    HttpResponse::Ok().json(docs)
}