// Nama File: s3service.rs
// Deskripsi: File ini bertujuan untuk menangani layanan amazon web service s3
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

use aws_sdk_s3::Client;
use std::error::Error;
use std::sync::Arc;
use actix_web::{web};
use crate::models::app_state::AppState;

pub async fn verify_bucket(client: &Client, bucket: &str) -> Result<(), Box<dyn Error + Send + Sync>>{
    let buckets = client.list_buckets().send().await?;
    let found = buckets.buckets().into_iter().any(|b| b.name().unwrap() == bucket);
    if found {
        println!("Bucket found");
        Ok(())
    } else {
        Err("Bucket not found".into())
    }
}

pub async fn upload_photo(
    data: Vec<u8>,
    ext: &str,
    state: web::Data<Arc<AppState>>
) -> Result<String, Box<dyn Error + Send + Sync>> {
    let body = aws_sdk_s3::primitives::ByteStream::from(data);
    let bucket = &state.bucket_name;
    let client = &state.s3_client;

    let content_type = match ext {
        "jpg" => "image/jpg",
        "png" => "image/png",
        "jpeg" => "image/jpeg",
        _ => "application/octet-stream",
    };

    let uuid = uuid::Uuid::new_v4();
    let key = format!("{}.{}", uuid, ext);

    client
        .put_object()
        .bucket(bucket.as_str())
        .key(&key)
        .body(body)
        .content_type(content_type)
        .send()
        .await?;

    Ok(key)
}


// pub async fn upload_photo(data: Vec<u8>, req: HttpRequest, state: web::Data<Arc<AppState>>) -> Result<String, Box<dyn Error + Send + Sync>>{
//     let body = aws_sdk_s3::primitives::ByteStream::from(data);
//     let bucket = &state.bucket_name;
//     let client = &state.s3_client;
// 
//     let extension = req
//         .headers()
//         .get("x-file-ext")
//         .and_then(|v| v.to_str().ok());
//     
//     let ext = match extension {
//         Some("jpg") | Some("png") | Some("jpeg") => extension.unwrap(),
//         Some(other) => return Err(format!("Unsupported file extension: {}", other).into()),
//         None => return Err("Missing file extension".into()), 
//     };
//         
// 
//     let content_type = match ext {
//         "jpg" => "image/jpg",
//         "png" => "image/png",
//         "jpeg" => "image/jpeg",
//         _ => "application/octet-stream",
//     };
// 
//     let uuid = uuid::Uuid::new_v4();
//     let key = format!("{}.{}", uuid, ext);
// 
//     client
//         .put_object()
//         .bucket(bucket.as_str())
//         .key(&key)
//         .body(body)
//         .content_type(content_type)
//         .send()
//         .await?;
//     
//     Ok(key)
// }