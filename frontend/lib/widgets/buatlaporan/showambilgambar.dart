import 'package:balapin/provider/laporan_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Fungsi bantu ambil lokasi pengguna
Future<Position> getCurrentPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are denied.');
    }
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}

Future<void> showModalAmbilGambar(
  BuildContext context,
  Function(XFile?) onImagePicked,
) async {
  final picker = ImagePicker();

  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      final laporanprovider = context.watch<LaporanProvider>();

      return CupertinoActionSheet(
        title: const Text(
          'Ambil gambar melalui',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Instrument-Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // Ambil dari Kamera
          CupertinoActionSheetAction(
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.camera);
              Navigator.pop(context);

              if (image != null) {
                try {
                  final position = await getCurrentPosition();
                  final lokasi = LatLng(position.latitude, position.longitude);
                  laporanprovider.setPickedLocation(lokasi);
                  debugPrint('Lokasi otomatis tersimpan: $lokasi');
                } catch (e) {
                  debugPrint('Gagal mendapatkan lokasi: $e');
                  // Optional: tampilkan snackbar atau dialog
                }
              }

              onImagePicked(image);
            },
            child: const Text(
              'Kamera',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Instrument-Sans',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Ambil dari Galeri
          CupertinoActionSheetAction(
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.gallery);
              Navigator.pop(context);
              onImagePicked(image);
            },
            child: const Text(
              'Galeri',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Instrument-Sans',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}
