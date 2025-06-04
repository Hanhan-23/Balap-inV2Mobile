import 'package:frontend/models/model_peta.dart';

class ModelBuatLaporFinal {
  final ModelBuatLaporan laporan;
  final String gambar;

  ModelBuatLaporFinal ({
    required this.laporan,
    required this.gambar,
  });

  factory ModelBuatLaporFinal.fromJson(Map<dynamic, dynamic> json) {
    return ModelBuatLaporFinal(
      laporan: json['laporan'], 
      gambar: json['gambar'],
    );}
}

class ModelBuatLaporan {
  final String judul;
  final String jenis;
  final String deskripsi;
  final String cuaca;
  final String persentase;
  final dynamic idMasyarakat;
  final ModelBuatPeta idPeta;
  final String status;

  ModelBuatLaporan ({
    required this.judul,
    required this.jenis,
    required this.deskripsi,
    required this.cuaca,
    required this.persentase,
    required this.idMasyarakat,
    required this.idPeta,
    required this.status,
  });

  factory ModelBuatLaporan.fromJson(Map<String, dynamic> json) {
    return ModelBuatLaporan(
      judul: json['judul'],
      jenis: json['jenis'],
      deskripsi: json['deskripsi'],
      cuaca: json['cuaca'],
      persentase: json['persentase'],
      idMasyarakat: json['id_masyarakat'],
      idPeta: json['id_peta'],
      status: json['status'],
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