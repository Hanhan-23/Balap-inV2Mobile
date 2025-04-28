use dotenvy::dotenv;
use mongodb::{Client, Collection};
use crate::model::{ Masyarakat, Pemerintah, Laporan, Rekomendasi, Notifikasi};

#[derive(Clone)]
pub struct MongoRepo {
    pub masyarakat_collection: Collection<Masyarakat>,
    pub pemerintah_collection: Collection<Pemerintah>,
    pub laporan_collection: Collection<Laporan>,
    pub rekomendasi_collection: Collection<Rekomendasi>,
    pub notifikasi_collection: Collection<Notifikasi>,
}

impl MongoRepo {
    pub fn new(client: &Client) -> Self {
        let db = client.database("balap_in");
        
        Self {
            masyarakat_collection: db.collection("masyarakat"),
            pemerintah_collection: db.collection("pemerintah"),
            laporan_collection: db.collection("laporan"),
            rekomendasi_collection: db.collection("rekomendasi"),
            notifikasi_collection: db.collection("notifikasi"),
        }
    }
}


