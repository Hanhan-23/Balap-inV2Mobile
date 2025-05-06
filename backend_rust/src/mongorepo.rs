use mongodb::{Client, Collection};
use mongodb::bson::oid::ObjectId;
use crate::models::laporanmodel::{Laporan, CardLaporan, DetailLaporan, LaporanBaru};
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
    pub buat_laporan_baru_collection: Collection<Laporan>,
    
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
            buat_laporan_baru_collection: db.collection("laporan"),
            
            rekomendasi_collection: db.collection("rekomendasi"),
            notifikasi_collection: db.collection("notifikasi"),
        }
    }
    
    pub async fn create_new_laporan(&self, laporan: LaporanBaru) -> Result<ObjectId, mongodb::error::Error> {
        let new_laporan = Laporan {
            id: ObjectId::new(),
            gambar: laporan.gambar,
            jenis: laporan.jenis,
            judul: laporan.judul,
            deskripsi: laporan.deskripsi,
            persentase: laporan.persentase,
            cuaca: laporan.cuaca,
            status: laporan.status,
            tgl_lapor: laporan.tgl_lapor,
            cluster: laporan.cluster,
            id_masyarakat: laporan.id_masyarakat,
            id_peta: laporan.id_peta,
        };

        let collection = &self.buat_laporan_baru_collection;
        let result = collection.insert_one(&new_laporan).await;
        
        match result { 
            Ok(_) => Ok(new_laporan.id),
            Err(e) => Err(e).expect("Error inserting document"),
        }
    }
}