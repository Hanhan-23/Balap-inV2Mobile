import 'package:frontend/models/model_peta.dart';

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
  final dynamic tglLapor;

  ModelCardLaporan({
    required this.id,
    required this.jenis,
    required this.judul,
    required this.deskripsi,
    required this.gambar,
    required this.tglLapor,
  });

  factory ModelCardLaporan.fromJson(Map<String, dynamic> json) {
    return ModelCardLaporan(
      id: json['_id']['\$oid'],
      jenis: json['jenis'], 
      judul: json['judul'], 
      deskripsi: json['deskripsi'], 
      gambar: json['gambar'],
      tglLapor: json['tgl_lapor']['\$date']['\$numberLong']
      );
  }
}

class ModelDetailLaporan {
  final dynamic id;
  final String jenis;
  final String judul;
  final dynamic tglLapor;
  final String gambar;
  final ModelPeta peta;
  final String deskripsi;

  ModelDetailLaporan({
    required this.id,
    required this.jenis,
    required this.judul,
    required this.tglLapor,
    required this.gambar,
    required this.peta,
    required this.deskripsi,
  });

  factory ModelDetailLaporan.fromJson(Map<String, dynamic> json) {
    return ModelDetailLaporan(
      id: json['_id']['\$oid'], 
      jenis: json['jenis'], 
      judul: json['judul'], 
      tglLapor: json['tgl_lapor']['\$date']['\$numberLong'], 
      gambar: json['gambar'], 
      peta: ModelPeta.fromJson(json['id_peta']),
      deskripsi: json['deskripsi']
    );
  }
}