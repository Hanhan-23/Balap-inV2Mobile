// Nama File: rekomendasiroute.rs
// Deskripsi: File ini bertujuan untuk menangani routingan dari data rekomendasi
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

use actix_web::web;
use crate::handlers::petahandler::get_peta_rekomendasi;
use crate::handlers::rekomendasihandler::{get_detail_rekomendasi, get_rekomendasi, get_rekomendasi_card};

pub fn rekomendasi_routes(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/rekomendasi")
            .route("", web::get().to(get_rekomendasi))
            .route("cards", web::get().to(get_rekomendasi_card))
            .route("/detail/{id}", web::get().to(get_detail_rekomendasi))
            .route("peta", web::get().to(get_peta_rekomendasi))
    );
}