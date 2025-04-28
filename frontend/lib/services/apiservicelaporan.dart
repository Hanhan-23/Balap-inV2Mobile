import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() async {
  var url = Uri.parse('http://127.0.0.1:8080/');

  var response = await http.get(url);
  var jsonResponse = convert.jsonDecode(response.body);

  print(jsonResponse);
}