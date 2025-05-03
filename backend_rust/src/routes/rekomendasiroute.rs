use actix_web::web;
use crate::handlers::rekomendasihandler::get_rekomendasi;

pub fn rekomendasi_routes(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/rekomendasi")
            .route("", web::get().to(get_rekomendasi))
    );
}