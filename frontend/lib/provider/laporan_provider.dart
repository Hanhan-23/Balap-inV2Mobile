import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LaporanProvider with ChangeNotifier {
  String? _gambar;
  String? _jenis;
  String? _cuaca;
  double? _nilaikerusakan;
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
    _nilaikerusakan = null;
    _pickedLocation = null;

    judulController.clear();
    deskripsiController.clear();

    notifyListeners();
  }
}
