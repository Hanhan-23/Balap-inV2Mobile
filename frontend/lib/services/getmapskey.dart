// Nama File: getmapskey.dart
// Deskripsi: File ini bertujuan untuk menangani api key google map yang telah ditentukan di gradle
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

import 'package:flutter/services.dart';


Future<String> getMapKey() async {
  const platform = MethodChannel('com.balapin.app/api_key');
  try {
    final String apiKey = await platform.invokeMethod('getApiKey');
    return apiKey;
  } on PlatformException catch (e) {
    return 'failed to get error: $e';
  }
}