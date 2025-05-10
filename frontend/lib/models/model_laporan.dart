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

class ModelCardLaporan {
  final dynamic id;
  final String jenis;
  final String judul;
  final String deskripsi;
  final String gambar;

  ModelCardLaporan({
    required this.id,
    required this.jenis,
    required this.judul,
    required this.deskripsi,
    required this.gambar
  });

  factory ModelCardLaporan.fromJson(Map<String, dynamic> json) {
    return ModelCardLaporan(
      id: json['_id'], 
      jenis: json['jenis'], 
      judul: json['judul'], 
      deskripsi: json['deskripsi'], 
      gambar: json['gambar']
      );
  }
}