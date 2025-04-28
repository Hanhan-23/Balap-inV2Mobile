use mongodb::{options::{ClientOptions}, Client};
use dotenvy::dotenv;
use std::env;

pub async fn init_mongo() -> mongodb::error::Result<(Client)>{
    dotenv().ok(); 
    let uri = env::var("MONGODB_URI").expect("MONGODB_URI must be set");
    
    let mut client_options = ClientOptions::parse(&uri).await.expect("Failed to parse MONGODB_URI");
    client_options.max_pool_size = Some(100);
    client_options.min_pool_size = Some(10);
    
    let client = Client::with_options(client_options)?;
    
    return Ok(client);
}