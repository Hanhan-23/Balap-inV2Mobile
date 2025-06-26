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

class ModelBuatPeta {
  final String alamat;
  final String jalan;
  final double latitude;
  final double longitude;

  ModelBuatPeta ({
    required this.alamat,
    required this.jalan,
    required this.latitude,
    required this.longitude
  });

  factory ModelBuatPeta.fromJson(Map<String, dynamic> json) {
    return ModelBuatPeta(
      alamat: json['alamat'], 
      jalan: json['jalan'], 
      latitude: json['latitude'], 
      longitude: json['longitude']
    );
  }
}

class ModelRekomendasiPeta {
  final String idRekomendasi;
  final String statusUrgent;
  final double tingkatUrgent;
  final String statusRekom;
  final String idLaporan;
  final String judul;
  final double latitude;
  final double longitude;
  final String alamat;

  ModelRekomendasiPeta({
    required this.idRekomendasi,
    required this.statusUrgent,
    required this.tingkatUrgent,
    required this.statusRekom,
    required this.idLaporan,
    required this.judul,
    required this.latitude,
    required this.longitude,
    required this.alamat,
  });

  factory ModelRekomendasiPeta.fromJson(Map<String, dynamic> json) {
    return ModelRekomendasiPeta(
      idRekomendasi: json['rekomendasi_id']['\$oid'], 
      statusUrgent: json['status_urgent'], 
      tingkatUrgent: json['tingkat_urgent'], 
      statusRekom: json['status_rekom'], 
      idLaporan: json['id_laporan']['\$oid'], 
      judul: json['judul'], 
      latitude: json['latitude'], 
      longitude: json['longitude'], 
      alamat: json['alamat']
    );
  }
}