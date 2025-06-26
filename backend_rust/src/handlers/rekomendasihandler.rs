use actix_web::{web, HttpResponse, Responder};
use futures::TryStreamExt;
use mongodb::bson::{doc};
use mongodb::bson::oid::ObjectId;
use serde_json::json;
use crate::models::rekomendasimodel::{Rekomendasi, SortQuery};
use crate::mongorepo::MongoRepo;

pub async fn get_rekomendasi(db: web::Data<MongoRepo>) -> impl Responder{
    let cursor = db.rekomendasi_collection.find(doc! {}).await.expect("Failed to find rekomendasi");
    let docs = cursor.try_collect::<Vec<Rekomendasi>>().await.expect("Failed to collect rekomendasi");
    
    HttpResponse::Ok().json(docs)
}

pub async fn get_rekomendasi_card(db: web::Data<MongoRepo>, query: web::Query<SortQuery>) -> impl Responder{
    let cursor = db.rekomendasi_collection.find(doc! { "status_rekom": { "$ne": "selesai" } }).await.expect("Failed to find rekomendasi");
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

pub async fn get_detail_rekomendasi(
    db: web::Data<MongoRepo>,
    oid: web::Path<String>
) -> impl Responder {
    let path = oid.into_inner();
    let obj_id = match ObjectId::parse_str(&path) {
        Ok(oid) => oid,
        Err(_) => return HttpResponse::BadRequest().body("Invalid ObjectId"),
    };

    let filter = doc! { "_id": obj_id };
    let rekom = db.rekomendasi_collection.find_one(filter).await.expect("Failed to find rekomendasi");

    if let Some(rekom) = rekom {
        let laporan_ids = &rekom.id_laporan;

        let filter_laporan = doc! { "_id": { "$in": laporan_ids } };
        let mut cursor = db.card_laporan_collection.find(filter_laporan).await.expect("Failed to find laporan");

        let mut laporan_list = Vec::new();
        while let Some(doc) = cursor.try_next().await.expect("Failed to read laporan cursor") {
            laporan_list.push(doc);
        }

        let result = json!({
            "rekomendasi_id": rekom.id,
            "status_urgent": rekom.status_urgent,
            "tingkat_urgent": rekom.tingkat_urgent,
            "status_rekom": rekom.status_rekom,
            "tgl_rekom": rekom.tgl_rekom,
            "jumlah_laporan": rekom.jumlah_laporan,
            "laporan_list": laporan_list
        });

        HttpResponse::Ok().json(result)
    } else {
        HttpResponse::NotFound().body("Rekomendasi not found")
    }
}