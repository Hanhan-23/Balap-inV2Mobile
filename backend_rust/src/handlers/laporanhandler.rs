use actix_web::{web, HttpResponse, Responder};
use futures::TryStreamExt;
use mongodb::bson;
use crate::models::laporanmodel::Laporan;
use crate::mongorepo::MongoRepo;

pub async fn get_laporan(db: web::Data<MongoRepo>) -> impl Responder {
    let cursor = db.laporan_collection.find(bson::doc! {}).await.expect("Failed to find documents");
    let docs = cursor.try_collect::<Vec<Laporan>>().await.expect("Failed to collect documents");

    HttpResponse::Ok().json(docs)
}