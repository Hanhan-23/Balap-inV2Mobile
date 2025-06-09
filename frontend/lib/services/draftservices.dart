import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

Future<dynamic>simpanDrafLaporan({
  required String? gambar,
  required String? judul,
  required String? jenis,
  required String? deskripsi,
  required String? cuaca,
  required double? nilaikerusakan,
  required LatLng? pickedLocation,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> daftarDraf = prefs.getStringList('daftar_draf') ?? [];

  String? gambarPath;
  if (gambar != null) {
    gambarPath = gambar;
  }

  final drafBaru = {
    "id": const Uuid().v4(),
    "gambar": gambarPath,
    "judul": judul,
    "jenis": jenis,
    "deskripsi": deskripsi,
    "cuaca": cuaca,
    "nilaikerusakan": nilaikerusakan,
    "pickedLocation": pickedLocation,
  };

  daftarDraf.add(json.encode(drafBaru));
  await prefs.setStringList('daftar_draf', daftarDraf);

  return 'draf';
}

Future<List<Map<String, dynamic>>> ambilSemuaDrafLaporan() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> daftarDraf = prefs.getStringList('daftar_draf') ?? [];

  return daftarDraf
      .map((drafJson) => json.decode(drafJson) as Map<String, dynamic>)
      .toList();
}

Future hapusDrafLaporan(String id) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> daftarDraf = prefs.getStringList('daftar_draf') ?? [];

  daftarDraf.removeWhere((drafJson) {
    final draf = json.decode(drafJson);
    return draf['id'] == id;
  });

  await prefs.setStringList('daftar_draf', daftarDraf);

  return true;
}

