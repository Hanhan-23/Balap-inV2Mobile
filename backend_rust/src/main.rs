// Nama File: main.rs
// Deskripsi: File ini bertujuan untuk inisialisasi dari aplikasi backend untuk mobile app
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025


mod config;
mod mongorepo;
mod models;
mod routes;
mod handlers;
mod utils;

use std::env;
use std::sync::Arc;
use actix_web::{web, App, HttpServer, middleware::{{Logger}}};
use mongodb::bson;
use crate::config::init_mongo;
use crate::mongorepo::MongoRepo;
use crate::utils::cors::cors_middleware;
use aws_sdk_s3::Client;
use aws_config::{Region};
use aws_config::meta::region::RegionProviderChain;
use crate::models::app_state::AppState;
use crate::utils::s3service::{verify_bucket};

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenvy::dotenv().ok();
    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));
    let uri = env::var("MONGODB_URI").expect("MONGODB_URI must be set");

    // init Client Mongodb
    let init_db = init_mongo(uri).await.expect("Failed to init mongo");

    let db = init_db.database("balap_in");
    if db.run_command(bson::doc! {"ping": 1}).await.is_ok() {
        println!("Connected to MongoDB");
    } else {
        println!("Failed to connect to MongoDB");
    }

    let mongorepo = MongoRepo::new(&init_db);

    //init Client aws
    let bucket_name = dotenvy::var("S3_BUCKET").expect("bucket not found");
    let region_provider = RegionProviderChain::first_try(Region::new("ap-southeast-1"));
    let config = aws_config::from_env().region(region_provider).load().await;
    let client = Client::new(&config);
    let bucket = &bucket_name.to_string();

    verify_bucket(&client, bucket).await.map_err(|e| std::io::Error::new(std::io::ErrorKind::Other, e))?;

    let ai_uri = dotenvy::var("AI_URI").expect("second server not found");

    let app_state = Arc::new(AppState {
        s3_client: client.clone(),
        bucket_name: bucket_name.clone(),
        ai_uri: ai_uri.clone(),
    });

    HttpServer::new(move || {
        App::new()
            .wrap(Logger::default())
            .wrap(cors_middleware())
            .app_data(web::Data::new(app_state.clone()))
            .app_data(web::Data::new(mongorepo.clone()))
            .configure(routes::laporanroute::laporan_routes)
            .configure(routes::rekomendasiroute::rekomendasi_routes)
            .configure(routes::notifikasiroute::notifikasi_route)
            .configure(routes::akunroute::akun_routes)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}