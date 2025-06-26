import 'package:balapin/models/model_rekomendasi.dart';
import 'package:balapin/services/service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<List<ModelCardRekomendasi>> getCardRekomendasi(String sort) async {
  var url = Uri.parse('$service/rekomendasi/cards?sort=$sort');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var responseJson = convert.jsonDecode(response.body) as List;
    return responseJson.map((e) => ModelCardRekomendasi.fromJson(e)).toList();
  } else {
    throw Exception("Failed fetch data rekomendasi");
  }
}

Future<ModelDetailRekomendasi> getDetailRekomendasi(dynamic id) async {
  var url = Uri.parse('$service/rekomendasi/detail/$id');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var responseJson = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return ModelDetailRekomendasi.fromJson(responseJson);
  } else {
    throw Exception("Failed to fetch Data");
  }
}