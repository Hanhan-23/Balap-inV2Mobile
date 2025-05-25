use mongodb::bson::oid::ObjectId;
use mongodb::bson::{DateTime};
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Rekomendasi{
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub jumlah_laporan: i64,
    pub status_urgent: String,
    pub tingkat_urgent: f64,
    pub status_rekom: String,
    pub tgl_rekom: DateTime,
    pub id_laporan: Vec<ObjectId>,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct RekomendasiCard{
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub status_urgent: String,
    pub status_rekom: String,
    pub tgl_rekom: DateTime,
    pub gambar: String,
    pub judul: String,
    pub jenis: String,
    pub alamat: String,
}