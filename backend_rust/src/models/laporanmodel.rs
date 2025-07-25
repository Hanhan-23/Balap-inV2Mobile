// Nama File: laporanmodel.rs
// Deskripsi: File ini bertujuan untuk menangani deklarasi tipe data dari data laporan
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

use mongodb::bson::oid::ObjectId;
use serde::{Deserialize, Serialize};
use crate::models::petamodel::{Peta, PetaBaru, PetaCardRekomendasi};
use mongodb::bson::DateTime;

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Laporan{
    #[serde(rename = "_id")]
    pub id : ObjectId,
    pub gambar: String,
    pub jenis: String,
    pub judul: String,
    pub deskripsi: String,
    pub persentase: f64,
    pub cuaca: String,
    pub status: String,
    pub tgl_lapor: DateTime,
    pub cluster: Option<i64>,
    pub id_masyarakat: ObjectId,
    pub id_peta: Peta
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct CardLaporan{
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub gambar: String,
    pub jenis: String,
    pub judul: String,
    pub deskripsi: String,
    pub status: String,
    pub tgl_lapor: DateTime,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct DetailLaporan{
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub gambar: String,
    pub jenis: String,
    pub judul: String,
    pub deskripsi: String,
    pub status: String,
    pub cuaca: String,
    pub tgl_lapor: DateTime,
    pub id_peta: Peta
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct LaporanBaru{
    pub jenis: String,
    pub judul: String,
    pub deskripsi: String,
    pub persentase: f64,
    pub cuaca: String,
    pub status: String,
    pub cluster: Option<i64>,
    pub id_masyarakat: ObjectId,
    pub id_peta: PetaBaru
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct LaporanCardRekomendasi{
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub gambar: String,
    pub jenis: String,
    pub judul: String,
    pub id_peta: PetaCardRekomendasi,
    pub status: String
}

#[derive(Deserialize)]
pub struct SortCardLaporan{
    pub period: Option<i8>,
    pub search: Option<String>,
}

#[derive(Deserialize)]
pub struct TextAnalysisResult {
    pub original_text: String,
    pub processed_text: String,
    pub predicted_label: String,
    pub confidence: f32,
    pub censored_text: String,
}

#[derive(Deserialize)]
pub struct SensorResponse {
    pub judul: TextAnalysisResult,
    pub deskripsi: TextAnalysisResult,
}