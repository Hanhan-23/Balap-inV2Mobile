use mongodb::bson::oid::ObjectId;
use mongodb::bson::Timestamp;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Notifikasi {
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub pesan: String,
    pub tgl_notif: Timestamp,
    pub id_rekomendasi: ObjectId
}