import 'package:balapin/models/model_laporan.dart';

class ModelCardRekomendasi {
  final dynamic id;
  final String statusUrgent;
  final double tingkatUrgent;
  final String statusRekom;
  final ModelCardLaporanRekomendasi idLaporan;

  ModelCardRekomendasi({
    required this.id,
    required this.statusUrgent,
    required this.tingkatUrgent,
    required this.statusRekom,
    required this.idLaporan,
  });

  factory ModelCardRekomendasi.fromJson(Map<String, dynamic> json) {
    return ModelCardRekomendasi(
      id: json['rekomendasi_id']['\$oid'],
      statusUrgent: json['status_urgent'],
      tingkatUrgent: json['tingkat_urgent'],
      statusRekom: json['status_rekom'],
      idLaporan: ModelCardLaporanRekomendasi.fromJson(json['id_laporan'])
    );
  }
}

class ModelCardLaporanRekomendasi {
  final dynamic id;
  final String gambar;
  final String jenis;
  final String judul;
  final String alamat;
  final String status;

  ModelCardLaporanRekomendasi({
    required this.id,
    required this.gambar,
    required this.jenis,
    required this.judul,
    required this.alamat,
    required this.status
  });

  factory ModelCardLaporanRekomendasi.fromJson(Map<String, dynamic> json) {
    return ModelCardLaporanRekomendasi(
      id: json['_id']['\$oid'], 
      gambar: json['gambar'], 
      jenis: json['jenis'], 
      judul: json['judul'], 
      alamat: json['id_peta']['alamat'],
      status: json['status']
    );
  }
}

class ModelDetailRekomendasi {
  final dynamic id;
  final String statusUrgent;
  final double tingkatUrgent;
  final String statusRekom;
  final int jumlahLaporan;
  final List<ModelCardLaporan> laporanList;

  ModelDetailRekomendasi({
    required this.id,
    required this.statusUrgent,
    required this.tingkatUrgent,
    required this.statusRekom,
    required this.jumlahLaporan,
    required this.laporanList,
  });

  factory ModelDetailRekomendasi.fromJson(Map<String, dynamic>json) {
    return ModelDetailRekomendasi(
      id: json['rekomendasi_id']['\$oid'], 
      statusUrgent: json['status_urgent'], 
      tingkatUrgent: json['tingkat_urgent'], 
      statusRekom: json['status_rekom'], 
      jumlahLaporan: json['jumlah_laporan'], 
      laporanList: (json['laporan_list'] as List<dynamic>)
        .map((e) => ModelCardLaporan.fromJson(e))
        .toList(),
    );
  }
}