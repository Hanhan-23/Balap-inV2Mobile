use aws_sdk_s3::Client;
use std::error::Error;

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