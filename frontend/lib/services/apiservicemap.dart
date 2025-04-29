import 'package:google_maps_flutter/google_maps_flutter.dart';

CameraPosition initialCameraPosition() {
  return CameraPosition(
    zoom: 15,
    target: LatLng(1.118475, 104.048461)
  );
}

MinMaxZoomPreference initialMinMaxZoom() {
  return MinMaxZoomPreference(10, null);
}