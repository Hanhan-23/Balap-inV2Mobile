use mongodb::bson::oid::ObjectId;
use mongodb::bson::{DateTime};
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Masyarakat {
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub tgl_pengguna: DateTime,
    pub token: String,
}

#[derive(Deserialize)]
pub struct TokenRequest {
    pub token: String,
}