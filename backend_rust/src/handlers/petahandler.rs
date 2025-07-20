// Nama File: petahandler.rs
// Deskripsi: File ini bertujuan untuk menangani logika dari peta interaktif untuk sisi mobile masyarakat
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

use actix_web::{web, HttpResponse, Responder};
use futures::TryStreamExt;
use mongodb::bson::doc;
use serde_json::json;
use crate::models::rekomendasimodel::Rekomendasi;
use crate::mongorepo::MongoRepo;
pub async fn get_peta_rekomendasi(
    db: web::Data<MongoRepo>,
) -> impl Responder{
    
    let cursor = db.rekomendasi_collection.find(doc! { "status_rekom": { "$ne": "selesai" } }).await.expect("Failed to find rekomendasi");
    let docs = cursor.try_collect::<Vec<Rekomendasi>>().await.expect("Failed to collect rekomendasi");
    
    let mut result = Vec::new();
    
    for rekom in docs {
        if let Some(first_laporan_id) = rekom.id_laporan.get(0) {
            
            if let Ok(Some(laporan)) = db.laporan_collection.find_one(doc! { "_id": first_laporan_id }).await {
                result.push(json!({
                    "rekomendasi_id": rekom.id,
                    "status_urgent": rekom.status_urgent,
                    "tingkat_urgent": rekom.tingkat_urgent,
                    "status_rekom": rekom.status_rekom,
                    "id_laporan": laporan.id,
                    "judul": laporan.judul,
                    "status": laporan.status,
                    "latitude": laporan.id_peta.latitude,
                    "longitude": laporan.id_peta.longitude,
                    "alamat": laporan.id_peta.alamat,
                }));
            }
        }
    }
    
    HttpResponse::Ok().json(result)
}