mod config;
mod mongorepo;
mod models;
mod routes;
mod handlers;
mod utils;

use actix_web::{web, App, HttpServer, middleware::{{Logger}}};
use mongodb::bson;
use crate::config::init_mongo;
use crate::mongorepo::MongoRepo;
use crate::utils::cors::cors_middleware;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    dotenvy::dotenv().ok();
    env_logger::init_from_env(env_logger::Env::new().default_filter_or("info"));

    let init_db = init_mongo().await.expect("Failed to init mongo");

    let db = init_db.database("balap_in");
    if db.run_command(bson::doc! {"ping": 1}).await.is_ok() {
        println!("Connected to MongoDB");
    } else {
        println!("Failed to connect to MongoDB");
    }

    let mongorepo = MongoRepo::new(&init_db);

    HttpServer::new(move || {
        App::new()
            .wrap(Logger::default())
            .wrap(cors_middleware())
            .app_data(web::Data::new(mongorepo.clone()))
            .configure(routes::laporanroute::laporan_routes)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}