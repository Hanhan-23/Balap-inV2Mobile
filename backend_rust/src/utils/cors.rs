// Nama File: cors.rs
// Deskripsi: File ini bertujuan untuk menangani cors origin
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

use actix_cors::Cors;

pub fn cors_middleware() -> Cors {
    Cors::default()
        .allowed_origin("http://localhost:8080")
        .allowed_methods(vec!["GET", "POST", "PUT", "DELETE", "OPTIONS"])
        .allowed_headers(vec!["Authorization", "Accept", "Content-Type"])
        .allowed_header("my-custom-header")
        .max_age(3600)
}