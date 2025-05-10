import 'package:frontend/services/service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:frontend/models/model_laporan.dart';

Future<List<ModelCardLaporan>> getCardLaporan() async {
  var url = Uri.parse('$service/laporan/cardlaporan');
  var response = await http.get(url);
  
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body) as List;
    return jsonResponse.map((e) => ModelCardLaporan.fromJson(e)).toList();
  } else {
    throw Exception("Failed to fetch Data");
  }
}