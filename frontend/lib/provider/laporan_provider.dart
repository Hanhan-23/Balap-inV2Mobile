// Nama File: laporan_provider.dart
// Deskripsi: File ini bertujuan untuk menangani penyediaan data untuk field buat laporan
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      throw Exception('Location permissions are denied.');
    }
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

class LaporanProvider with ChangeNotifier {
  String? _gambar;
  String? _jenis;
  String? _cuaca;
  double _nilaikerusakan = 0.0;
  LatLng? _pickedLocation;

  // Controller untuk text input
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  String? get gambar => _gambar;
  String? get judul => judulController.text;
  String? get jenis => _jenis;
  String? get deskripsi => deskripsiController.text;
  String? get cuaca => _cuaca;
  double? get nilaikerusakan => _nilaikerusakan;
  LatLng? get pickedLocation => _pickedLocation;

  void setGambar(String gambar) {
    _gambar = gambar;
    notifyListeners();
  }

  void setJenis(String jenis) {
    _jenis = jenis;
    notifyListeners();
  }

  void setCuaca(String cuaca) {
    _cuaca = cuaca;
    notifyListeners();
  }

  void setNilaiKerusakan(double nilaikerusakan) {
    _nilaikerusakan = nilaikerusakan;
    notifyListeners();
  }

  void setPickedLocation(LatLng? pickedLocation) {
    _pickedLocation = pickedLocation;
    notifyListeners();
  }

  void clearLaporan() {
    _gambar = null;
    _jenis = null;
    _cuaca = null;
    _nilaikerusakan = 0.0;
    _pickedLocation = null;

    judulController.clear();
    deskripsiController.clear();

    notifyListeners();
  }

void loadDrafProvider(Map<String, dynamic> draf) {
  _gambar = draf['gambar'];
  judulController.text = draf['judul'] ?? '';
  _jenis = draf['jenis'];
  deskripsiController.text = draf['deskripsi'] ?? '';
  _cuaca = draf['cuaca'];
  _nilaikerusakan = (draf['nilaikerusakan'] ?? 0.0).toDouble();

  final location = draf['pickedLocation'];
  if (location != null) {
    List<dynamic> locationList;

    if (location is String) {
      locationList = jsonDecode(location);
    } else {
      locationList = location;
    }

    if (locationList.length == 2) {
      _pickedLocation = LatLng(locationList[0], locationList[1]);
    } else {
      _pickedLocation = null;
    }
  } else {
    _pickedLocation = null;
  }

  notifyListeners();
}

}
