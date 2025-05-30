class ModelNotifikasi {
  final dynamic id;
  final String pesan;
  final dynamic tglNotif;
  final dynamic idRekomendasi;
  final String statusUrgent;
  final dynamic idLaporan;
  final String jalan;

  ModelNotifikasi({
    required this.id,
    required this.pesan,
    required this.tglNotif,
    required this.idRekomendasi,
    required this.statusUrgent,
    required this.idLaporan,
    required this.jalan
  });

  factory ModelNotifikasi.fromJson(Map<String, dynamic> json) {
    return ModelNotifikasi(
      id: json['_id']['\$oid'], 
      pesan: json['pesan'],
      tglNotif: json['tgl_notif']['\$date']['\$numberLong'],
      idRekomendasi: json['id_rekomendasi']['\$oid'], 
      statusUrgent: json['status_urgent'], 
      idLaporan: json['id_laporan']['\$oid'], 
      jalan: json['jalan'],
    );
  }
}