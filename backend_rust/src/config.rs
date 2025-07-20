// Nama File: config.rs
// Deskripsi: File ini bertujuan untuk menangani konfigurasi database
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025


use mongodb::{options::{ClientOptions}, Client};

pub async fn init_mongo(uri: String) -> mongodb::error::Result<Client>{
    let mut client_options = ClientOptions::parse(&uri).await.expect("Failed to parse MONGODB_URI");
    client_options.max_pool_size = Some(500);
    client_options.min_pool_size = Some(50);
    
    let client = Client::with_options(client_options)?;
    
    Ok(client)
}