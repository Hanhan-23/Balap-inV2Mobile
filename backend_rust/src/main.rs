pub mod model;
mod database;
mod mongorepo;
use actix_web::{get, post, web, App, HttpResponse, HttpServer, Responder, middleware::{{Logger}}};
use futures::TryStreamExt;
use mongodb::bson;
use crate::database::init_mongo;
use crate::model::Laporan;
use crate::mongorepo::MongoRepo;

#[get("/laporan")]
async fn get_laporan(db: web::Data<MongoRepo>) -> impl Responder {
    let cursor = db.laporan_collection.find(bson::doc! {}).await.expect("Failed to find documents");
    let docs = cursor.try_collect::<Vec<Laporan>>().await.expect("Failed to collect documents");
    
    HttpResponse::Ok().json(docs)
}

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
            .app_data(web::Data::new(mongorepo.clone()))
            .service(get_laporan)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}