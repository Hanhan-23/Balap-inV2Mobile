use mongodb::bson::oid::ObjectId;
use mongodb::bson::Timestamp;
use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize, Clone)]
pub struct Masyarakat {
    #[serde(rename = "_id")]
    pub id: ObjectId,
    pub tgl_pengguna: Timestamp,
    pub token: String,
}