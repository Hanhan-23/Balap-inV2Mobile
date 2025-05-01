use dotenvy::dotenv;
use mongodb::{Client, Collection};
use crate::models::laporanmodel::{Laporan, CardLaporan, DetailLaporan};
use crate::models::masyarakatmodel::Masyarakat;
use crate::models::notifikasimodel::Notifikasi;
use crate::models::pemerintahmodel::Pemerintah;
use crate::models::rekomendasimodel::Rekomendasi;

#[derive(Clone)]
pub struct MongoRepo {
    pub masyarakat_collection: Collection<Masyarakat>,
    pub pemerintah_collection: Collection<Pemerintah>,
    
    // laporan
    pub laporan_collection: Collection<Laporan>,
    pub card_laporan_collection: Collection<CardLaporan>,
    pub detail_laporan_collection: Collection<DetailLaporan>,
    
    pub rekomendasi_collection: Collection<Rekomendasi>,
    pub notifikasi_collection: Collection<Notifikasi>,
}

impl MongoRepo {
    pub fn new(client: &Client) -> Self {
        let db = client.database("balap_in");
        
        Self {
            masyarakat_collection: db.collection("masyarakat"),
            pemerintah_collection: db.collection("pemerintah"),
            
            // laporan
            laporan_collection: db.collection("laporan"),
            card_laporan_collection: db.collection("laporan"),
            detail_laporan_collection: db.collection("laporan"),
            
            rekomendasi_collection: db.collection("rekomendasi"),
            notifikasi_collection: db.collection("notifikasi"),
        }
    }
}


