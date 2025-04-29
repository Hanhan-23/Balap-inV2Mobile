use mongodb::bson::oid::ObjectId;
use mongodb::bson::Timestamp;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Rekomendasi{
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub jumlah_laporan: i64,
    pub status_urgent: String,
    pub tingkat_urgent: f64,
    pub status_rekom: String,
    pub tgl_rekom: Timestamp,
    pub id_laporan: Vec<ObjectId>,
}