use mongodb::bson::oid::ObjectId;
use serde::{Deserialize, Serialize};

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