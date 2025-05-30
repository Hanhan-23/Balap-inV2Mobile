use mongodb::bson::oid::ObjectId;
use mongodb::bson::DateTime;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Notifikasi {
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub pesan: String,
    pub tgl_notif: DateTime,
    pub id_rekomendasi: Option<ObjectId>
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct RekomendasiNotifikasi {
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub status_urgent: String,
    pub status_rekom: String,
    pub id_laporan: Vec<ObjectId>,
}