import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert' as convert;

import 'package:balapin/services/apiservicelaporan.dart';

void main() {
  test('kirimLaporan mengembalikan "berhasil" jika response success', () async {
    final mockClient = MockClient((request) async {
      final map = {'status': 'success'};
      return http.Response(convert.jsonEncode(map), 200);
    });

    final fields = {
      "judul": "Jalan Rusak",
      "jenis": "jalan",
      "deskripsi": "Retak parah",
      "cuaca": "cerah",
      "persentase": 3.0,
      "status": "selesai",
      "id_masyarakat": "68050a842916f14bdf68b6c5",
      "id_peta": {
        "alamat": "Jl. Contoh",
        "jalan": "Jl. Contoh Raya",
        "latitude": -6.2,
        "longitude": 106.8,
      },
    };

    // Mock file path
    final result = await kirimLaporan(mockClient, fields, './assets/images/logo.png');

    expect(result, equals('berhasil'));
  });

  test('kirimLaporan mengembalikan "gagal" jika response 400', () async {
    final mockClient = MockClient((request) async {
      return http.Response('Bad Request', 400);
    });

    final fields = {
      "judul": "Jalan Rusak",
      "jenis": "jalan",
      "deskripsi": "Retak parah",
      "cuaca": "cerah",
      "persentase": 3.0,
      "status": "selesai",
      "id_masyarakat": "68050a842916f14bdf68b6c5",
      "id_peta": {
        "alamat": "Jl. Contoh",
        "jalan": "Jl. Contoh Raya",
        "latitude": -6.2,
        "longitude": 106.8,
      },
    };

    final result = await kirimLaporan(mockClient, fields, './assets/images/logo.png');

    expect(result, equals('gagal'));
  });
}
