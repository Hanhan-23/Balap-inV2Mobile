import 'package:frontend/services/getmapskey.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<String> geocodelocation(pickedLocation) async {
  String mapskey = await getMapKey();
  LatLng latLng = await pickedLocation;
  double lat = latLng.latitude;
  double lng = latLng.longitude;

  final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$mapskey');
  // final url = Uri.parse('https://geocode.googleapis.com/v4beta/geocode/location?location.latitude=$lat&location.longitude=$lng&key=API_KEY');
  final response = await http.get(url);
  
  final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
  final results = jsonResponse['results'] as List;
  print(results);
  
  if (results.isNotEmpty) {
    final formattedAddress = results[0]['formatted_address'];
    return formattedAddress;
  } else {
    return 'Tidak ada alamat';
  }
}
