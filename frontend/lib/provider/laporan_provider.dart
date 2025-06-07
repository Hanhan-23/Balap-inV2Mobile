import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LaporanProvider with ChangeNotifier {
  File? _gambar;
  String? _judul;
  String? _jenis;
  String? _deskripsi;
  String? _cuaca;
  double? _nilaikerusakan;
  LatLng? _pickedLocation;

  File? get gambar => _gambar;
  String? get judul => _judul;
  String? get jenis => _jenis;
  String? get deskripsi => _deskripsi;
  String? get cuaca => _cuaca;
  double? get nilaikerusakan => _nilaikerusakan;
  LatLng? get pickedLocation => _pickedLocation;
  
  void setGambar(File gambar) {
    _gambar = gambar;
    notifyListeners();
  }

  void setJudul(String judul) {
    _judul = judul;
    notifyListeners();
  }

  void setJenis(String jenis) {
    _jenis = jenis;
    notifyListeners();
  }

  void setDeskripsi(String deskripsi) {
    _deskripsi = deskripsi;
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
    _judul = null;
    _jenis = null;
    _deskripsi = null;
    _cuaca = null;
    _nilaikerusakan = null;
    _pickedLocation = null;
    notifyListeners();
  }
}