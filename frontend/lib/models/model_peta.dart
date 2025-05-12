class ModelPeta {
  final dynamic id;
  final String alamat;
  final String jalan;
  final double latitude;
  final double longitude;

  ModelPeta({
    required this.id,
    required this.alamat,
    required this.jalan,
    required this.latitude,
    required this.longitude
  });

  factory ModelPeta.fromJson(Map<String, dynamic> json) {
    return ModelPeta(
      id: json['_id']['\$oid'], 
      alamat: json['alamat'], 
      jalan: json['jalan'], 
      latitude: json['latitude'], 
      longitude: json['longitude']
    );
  }
}