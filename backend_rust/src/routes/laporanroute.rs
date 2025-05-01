use actix_web::{web};
use crate::handlers::laporanhandler::{get_card_laporan, get_detail_laporan, get_laporan};

pub fn laporan_routes(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/laporan")
            .route("", web::get().to(get_laporan))
            .route("cardlaporan", web::get().to(get_card_laporan))
            .route(
                "/detail/{id}",
                web::get().to(get_detail_laporan),
            )
    );
}