// Nama File: apiservicenotifikasi.dart
// Deskripsi: File ini bertujuan untuk menangani API notifikasi
// Dibuat oleh: Farhan Ramadhan - Nim: 3312301105
// Tanggal: 20 Juli 2025

import 'dart:convert';

import 'package:balapin/models/model_notifikasi.dart';
import 'package:balapin/services/service.dart';
import 'package:http/http.dart' as http;

Future<List<ModelNotifikasi>> getCardNotifikasi() async {
  var url = Uri.parse('$service/notifikasi');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var responseJson = jsonDecode(response.body) as List;
    return responseJson.map((e) => ModelNotifikasi.fromJson(e)).toList();
  } else {
    throw Exception("Failed fetch data rekomendasi");
  }
}