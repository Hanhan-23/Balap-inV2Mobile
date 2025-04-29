use mongodb::bson::oid::ObjectId;
use mongodb::bson::Timestamp;
use serde::{Deserialize, Serialize};
use crate::models::petamodel::Peta;

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Laporan {
    #[serde(rename = "_id")]
    pub id : ObjectId,
    pub gambar: String,
    pub jenis: String,
    pub judul: String,
    pub deskripsi: String,
    pub persentase: f64,
    pub cuaca: String,
    pub status: String,
    pub tgl_lapor: Timestamp,
    pub cluster: i64,
    pub id_masyarakat: ObjectId,
    pub id_peta: Peta
}