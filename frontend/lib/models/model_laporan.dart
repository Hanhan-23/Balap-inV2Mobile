class ModelLaporan {
  final dynamic id;
  final String gambar;

  ModelLaporan ({
    required this.id,
    required this.gambar,
  });

  factory ModelLaporan.fromJson(Map<String, dynamic> json) {
    return ModelLaporan(
      id: json['_id'], 
      gambar: json['gambar']
    );}

}