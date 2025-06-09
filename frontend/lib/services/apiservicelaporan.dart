import 'package:frontend/services/geocodmaps.dart';
import 'package:frontend/services/service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:frontend/models/model_laporan.dart';
import 'package:mime/mime.dart';

Future<List<ModelCardLaporan>> getCardLaporan(
  int period,
  String? search,
) async {
  final queryParams = {
    'period': period.toString(),
    if (search != null) 'search': search,
  };

  final url = Uri.parse(
    '$service/laporan/cards',
  ).replace(queryParameters: queryParams);

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResponse = convert.jsonDecode(response.body) as List;
    return jsonResponse.map((e) => ModelCardLaporan.fromJson(e)).toList();
  } else {
    throw Exception("Failed to fetch Data");
  }
}

Future<ModelDetailLaporan> getDetailLaporan(id) async {
  var url = Uri.parse('$service/laporan/detail/$id');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return ModelDetailLaporan.fromJson(jsonResponse[0]);
  } else {
    throw Exception("Failed to fetch Data");
  }
}

Future buatLapor(
  String? gambar,
  String? judul,
  String? jenis,
  String? deskripsi,
  String? cuaca,
  double? nilaikerusakan,
  LatLng? pickedLocation,
) async {
  final handle = await handleLaporan(
    gambar,
    judul,
    jenis,
    deskripsi,
    cuaca,
    nilaikerusakan,
    pickedLocation,
  );

  if (handle == true) {
    if (jenis == 'Jalan') {
      jenis = 'jalan';
    } else if (jenis == 'Lampu Jalan') {
      jenis = 'lampu_jalan';
    } else if (jenis == 'Jembatan') {
      jenis = 'jembatan';
    }

    if (cuaca == 'Cerah') {
      cuaca = 'cerah';
    } else if (cuaca == 'Hujan') {
      cuaca = 'hujan';
    }

    double latitude = pickedLocation!.latitude;
    double longitude = pickedLocation.longitude;
    String alamat = await geocodelocation(pickedLocation);
    String jalan = await geocodejalan(pickedLocation);

    var client = http.Client();

    try {
      var url = Uri.parse('$service/laporan/uploadlaporan');

      final laporanJson = {
        "judul": judul,
        "jenis": jenis,
        "deskripsi": deskripsi,
        "cuaca": cuaca,
        "persentase": nilaikerusakan,
        "status": "selesai",
        "cluster": null,
        "id_masyarakat": "680577cc557c0d8723af0b13",
        "id_peta": {
          "alamat": alamat,
          "jalan": jalan,
          "latitude": latitude,
          "longitude": longitude,
        },
      };

      var request = http.MultipartRequest('POST', url);

      final mimeType = lookupMimeType(gambar!);
      if (mimeType == null ||
          !(mimeType == 'image/png' ||
              mimeType == 'image/jpeg' ||
              mimeType == 'image/jpg')) {
        throw Exception(
          'Tipe gambar tidak didukung. Harus PNG, JPG, atau JPEG.',
        );
      }

      request.files.add(
        await http.MultipartFile.fromPath('gambar', gambar),
      );

      request.fields['laporan'] = convert.jsonEncode(laporanJson);

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var body = response.body;
        var jsonDecodeBody = convert.jsonDecode(body);

        if (jsonDecodeBody['status'] == 'success') {
          return 'berhasil';
        } else if (jsonDecodeBody['status'] == 'failed') {
          return 'gagal';
        }
      } else if (response.statusCode == 400) {
        return 'gagal';
      }
    } catch (e) {
      return 'gagal';
    } finally {
      client.close();
    }
  } else {
    return 'gagal';
  }
}

Future<bool> handleLaporan(
  String? gambar,
  String? judul,
  String? jenis,
  String? deskripsi,
  String? cuaca,
  double? nilaikerusakan,
  LatLng? pickedLocation,
) async {
  final judulValid = judul != null && judul.trim().isNotEmpty;
  final deskripsiValid = deskripsi != null && deskripsi.trim().isNotEmpty;
  final jenisValid = jenis != null && jenis.trim().isNotEmpty;
  final cuacaValid = cuaca != null && cuaca.trim().isNotEmpty;
  final nilaiValid = nilaikerusakan != null && nilaikerusakan > 0.0;
  final lokasiValid = pickedLocation != null;
  final gambarValid = gambar != null;

  if (judulValid &&
      deskripsiValid &&
      jenisValid &&
      cuacaValid &&
      nilaiValid &&
      lokasiValid &&
      gambarValid) {
    return true;
  } else {
    return false;
  }
}

Future<bool> handleDraftLaporan(
  String? gambar,
  String? judul,
  String? jenis,
  String? deskripsi,
  String? cuaca,
  double? nilaikerusakan,
  LatLng? pickedLocation,
) async {
  final judulValid = judul != null && judul.trim().isNotEmpty;
  final deskripsiValid = deskripsi != null && deskripsi.trim().isNotEmpty;

  if (gambar != null ||
      judulValid ||
      (jenis != null && jenis.isNotEmpty) ||
      deskripsiValid ||
      (cuaca != null && cuaca.isNotEmpty) ||
      (nilaikerusakan != null && nilaikerusakan > 0.0) ||
      pickedLocation != null) {
    return true;
  } else {
    return false;
  }
}
