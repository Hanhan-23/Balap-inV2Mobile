// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:balapin/provider/laporan_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  group('LaporanProvider', () {
    late LaporanProvider provider;

    setUp(() {
      provider = LaporanProvider();
    });

    test('Setters harus menyimpan data dengan benar', () {
      provider.judulController.text = "Jalan Retak";
      provider.deskripsiController.text = "Di depan sekolah";
      provider.setGambar("foto.jpg");
      provider.setJenis("jalan");
      provider.setCuaca("cerah");
      provider.setNilaiKerusakan(2.5);
      provider.setPickedLocation(const LatLng(-6.2, 106.8));

      expect(provider.judul, "Jalan Retak");
      expect(provider.deskripsi, "Di depan sekolah");
      expect(provider.gambar, "foto.jpg");
      expect(provider.jenis, "jalan");
      expect(provider.cuaca, "cerah");
      expect(provider.nilaikerusakan, 2.5);
      expect(provider.pickedLocation?.latitude, -6.2);
      expect(provider.pickedLocation?.longitude, 106.8);
    });

    test('clearLaporan harus reset semua data', () {
      // Set nilai dulu
      provider.judulController.text = "Judul";
      provider.deskripsiController.text = "Deskripsi";
      provider.setGambar("gambar.jpg");
      provider.setJenis("lampu");
      provider.setCuaca("hujan");
      provider.setNilaiKerusakan(5.0);
      provider.setPickedLocation(const LatLng(-7.0, 110.0));

      // Lalu clear
      provider.clearLaporan();

      expect(provider.judul, '');
      expect(provider.deskripsi, '');
      expect(provider.gambar, isNull);
      expect(provider.jenis, isNull);
      expect(provider.cuaca, isNull);
      expect(provider.nilaikerusakan, 0.0);
      expect(provider.pickedLocation, isNull);
    });
  });
}
