// Nama File: petamodel.rs
// Deskripsi: File ini bertujuan untuk menangani deklarasi tipe data dari data peta seperti titik lokasi dan alamat
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

use mongodb::bson::oid::ObjectId;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Peta {
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub alamat: String,
    pub jalan: String,
    pub latitude: f64,
    pub longitude: f64,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct PetaCardRekomendasi {
    pub alamat: String,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct PetaBaru {
    pub alamat: String,
    pub jalan: String,
    pub latitude: f64,
    pub longitude: f64,
}