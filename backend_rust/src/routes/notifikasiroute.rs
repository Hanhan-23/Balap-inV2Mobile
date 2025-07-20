// Nama File: notifikasiroute.rs
// Deskripsi: File ini bertujuan untuk menangani routingan dari data notifikasi
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

use actix_web::{web};
use crate::handlers::notifikasihandler::get_card_notifikasi;
pub fn notifikasi_route(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/notifikasi")
            .route("", web::get().to(get_card_notifikasi))
    );
}
