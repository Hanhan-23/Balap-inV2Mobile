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