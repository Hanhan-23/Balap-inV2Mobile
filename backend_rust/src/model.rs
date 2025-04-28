use mongodb::bson::{oid::ObjectId, Timestamp};
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Masyarakat {
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub tgl_pengguna: Timestamp,
    pub token: String,
}

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Pemerintah {
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub alamat: String,
    pub nama_lengkap: String,
    pub email: String,
    pub no_pegawai: i32,
    pub no_telp: String,
    pub password: String,
    pub status: String
}

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

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Peta {
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub alamat: String,
    pub jalan: String,
    pub latitude: f64,
    pub longitude: f64,
    pub id_laporan: ObjectId,
}

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

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Notifikasi {
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub pesan: String,
    pub tgl_notif: Timestamp,
    pub id_rekomendasi: ObjectId
}