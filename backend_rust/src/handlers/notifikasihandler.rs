use actix_web::{web, HttpResponse, Responder};
use futures::TryStreamExt;
use mongodb::bson::doc;
use serde_json::json;
use crate::models::notifikasimodel::Notifikasi;
use crate::mongorepo::MongoRepo;

pub async fn get_card_notifikasi(db: web::Data<MongoRepo>) -> impl Responder {
    let cursor = db.notifikasi_collection
        .find(doc! {})
        .sort(doc! {"tgl_notif": -1})
        .limit(10)
        .await
        .expect("Failed to find documents.");

    let docs = cursor
        .try_collect::<Vec<Notifikasi>>()
        .await
        .expect("Failed to collect documents.");

    let mut result = Vec::new();

    for doc in docs {
        if let Some(id_rekomendasi) = doc.id_rekomendasi {
            if let Ok(Some(rekomendasi)) = db.notifikasi_rekomendasi_collection
                .find_one(doc! { "_id": id_rekomendasi })
                .await
            {
                if let Some(id_laporan) = rekomendasi.id_laporan.get(0) {
                    if let Ok(Some(laporan)) = db.laporan_collection
                        .find_one(doc! { "_id": id_laporan })
                        .await
                    {
                        result.push(json!({
                            "_id": doc.id,
                            "pesan": doc.pesan,
                            "tgl_notif": doc.tgl_notif,
                            "id_rekomendasi": rekomendasi.id,
                            "status_urgent": rekomendasi.status_urgent,
                            "id_laporan": id_laporan,
                            "jalan": laporan.id_peta.jalan,
                        }));
                    }
                }
            }
        }
    }

    HttpResponse::Ok().json(result)
}