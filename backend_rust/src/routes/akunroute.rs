// Nama File: akunroute.rs
// Deskripsi: File ini bertujuan untuk menangani routingan dari akun masyarakat
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

use actix_web::{web};
use crate::handlers::akunhandler::{buat_akun_masyarakat, get_akun_masyarakat};

pub fn akun_routes(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/akun")
            .route("buat", web::post().to(buat_akun_masyarakat))
            .route("auth", web::post().to(get_akun_masyarakat))
    );
}