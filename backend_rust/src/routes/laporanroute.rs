use actix_web::web;
use crate::handlers::laporanhandler::get_laporan;

pub fn init_routes(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/laporan")
            .route("", web::get().to(get_laporan))
    );
}