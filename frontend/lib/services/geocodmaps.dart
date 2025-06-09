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
  
  if (results.isNotEmpty) {
    final formattedAddress = results[0]['formatted_address'];
    return formattedAddress;
  } else {
    return 'Tidak ada alamat';
  }
}

Future<String> geocodejalan(LatLng pickedLocation) async {
  LatLng latLng = pickedLocation;
  double lat = latLng.latitude;
  double lng = latLng.longitude;

  final url = Uri.parse(
    'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lng&format=json',
  );

  final response = await http.get(
    url,
    headers: {
      'User-Agent': 'FlutterApp',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
    final address = jsonResponse['address'];

    if (address != null && address['road'] != null) {
      return address['road']; 
    } else {
      return 'Alamat jalan tidak ditemukan';
    }
  } else {
    return 'Alamat jalan tidak ada';
  }
}