use actix_web::{web};
use crate::handlers::notifikasihandler::get_card_notifikasi;
pub fn notifikasi_route(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/notifikasi")
            .route("", web::get().to(get_card_notifikasi))
    );
}
