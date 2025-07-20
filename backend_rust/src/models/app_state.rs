// Nama File: s3service.rs
// Deskripsi: File ini bertujuan untuk menangani statement yang dibuat agar disediakan di seluruh aplikasi
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025


use aws_sdk_s3::Client;

#[derive(Clone)]
pub struct AppState {
    pub s3_client: Client,
    pub bucket_name: String,
    pub ai_uri: String,
}