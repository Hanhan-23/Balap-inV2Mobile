import 'dart:convert';

import 'package:balapin/models/model_akun.dart';
import 'package:balapin/services/service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<ModelAkunMasyarakat?> buatAkunMasyarakat() async {
  final url = Uri.parse('$service/akun/buat');
  final response = await http.post(url);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final token = jsonResponse['token'];
    final id = jsonResponse['id'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', token);
    await prefs.setString('user_id', id);

    print('akun dibuat');
    return ModelAkunMasyarakat.fromJson(jsonResponse);
  } else {
    print("Gagal membuat akun: ${response.body}");
    return null;
  }
}

Future<String?> checkAkunMasyarakat() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('user_token');

  if (token != null) {
    return token;
  }

  final akunBaru = await buatAkunMasyarakat();

  if (akunBaru != null && akunBaru.token.isNotEmpty) {
    await prefs.setString('user_token', akunBaru.token);
    await prefs.setString('user_id', akunBaru.id);
    print('tidak ada akun, akun baru dibuat');
  }

  return null;
}
