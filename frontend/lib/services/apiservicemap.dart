// Nama File: apiservicemap.dart
// Deskripsi: File ini bertujuan untuk menangani API untuk penampilan titik lokasi perekomendasian untuk peta
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

import 'package:balapin/models/model_peta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:balapin/services/service.dart';
import 'dart:convert' as convert;

CameraPosition initialCameraPosition() {
  return CameraPosition(
    zoom: 15,
    target: LatLng(1.118475, 104.048461)
  );
}

MinMaxZoomPreference initialMinMaxZoom() {
  return MinMaxZoomPreference(10, null);
}

Future<List<ModelRekomendasiPeta>> markerMapApi() async {
  var url = Uri.parse('$service/rekomendasi/peta');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var responseJson = convert.jsonDecode(response.body) as List;
    return responseJson.map((e) => ModelRekomendasiPeta.fromJson(e)).toList();
  } else {
    throw Exception("Failed to fetch Data");
  }
}