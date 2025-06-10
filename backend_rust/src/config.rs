use mongodb::{options::{ClientOptions}, Client};

pub async fn init_mongo(uri: String) -> mongodb::error::Result<Client>{
    let mut client_options = ClientOptions::parse(&uri).await.expect("Failed to parse MONGODB_URI");
    client_options.max_pool_size = Some(100);
    client_options.min_pool_size = Some(10);
    
    let client = Client::with_options(client_options)?;
    
    Ok(client)
}