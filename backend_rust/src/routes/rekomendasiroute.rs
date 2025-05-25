use actix_web::web;
use crate::handlers::rekomendasihandler::{get_rekomendasi, get_rekomendasi_card};

pub fn rekomendasi_routes(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/rekomendasi")
            .route("", web::get().to(get_rekomendasi))
            .route("getcard", web::get().to(get_rekomendasi_card))
    );
}