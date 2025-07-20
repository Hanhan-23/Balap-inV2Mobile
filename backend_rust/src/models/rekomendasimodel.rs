// Nama File: rekomendasimodel.rs
// Deskripsi: File ini bertujuan untuk menangani deklarasi tipe data dari data rekomendasi
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

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

#[derive(Deserialize)]
pub struct SortQuery {
    pub sort: Option<String>,
}