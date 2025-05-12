use aws_sdk_s3::Client;
use std::error::Error;
use actix_web::{HttpRequest};
use mongodb::bson::uuid;

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

pub async fn upload_photo(client: &Client, bucket: &str, data: Vec<u8>, req: HttpRequest) {
    let body = aws_sdk_s3::primitives::ByteStream::from(data);

    let ext = req
        .headers()
        .get("x-file-ext")
        .and_then(|v| v.to_str().ok())
        .unwrap_or(
            "jpg"
        );
        

    let content_type = match ext {
        "jpg" => "image/jpg",
        "png" => "image/png",
        "jpeg" => "image/jpeg",
        _ => "application/octet-stream",
    };

    let uuid = uuid::Uuid::new();
    let key = format!("{}{}", uuid, ext);

    let result = client
        .put_object()
        .bucket(bucket)
        .key(key)
        .body(body)
        .content_type(content_type)
        .send()
        .await
        .unwrap();
    
    println!("{:?}", result);
}