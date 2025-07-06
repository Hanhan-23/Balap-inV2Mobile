use actix_web::{web};
use crate::handlers::akunhandler::{buat_akun_masyarakat};

pub fn akun_routes(cfg: &mut web::ServiceConfig) {
    cfg.service(
        web::scope("/akun")
            .route("buat", web::post().to(buat_akun_masyarakat))
    );
}