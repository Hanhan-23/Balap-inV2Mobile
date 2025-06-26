import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:balapin/pages/petapersebaran.dart';
import 'package:balapin/services/apiservicemap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBeranda extends StatefulWidget {
  const MapBeranda({super.key});

  @override
  State<MapBeranda> createState() => _MapBerandaState();
}

class _MapBerandaState extends State<MapBeranda> {

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _addMarkers();
  }

  void _addMarkers() async {
    final data = await markerMapApi();

    final List<Marker> apiMarkers = data.map((item) {
      double hue = BitmapDescriptor.hueBlue;

      if (item.statusUrgent == 'tinggi') {
        hue = BitmapDescriptor.hueRed;
      } else if (item.statusUrgent == 'sedang') {
        hue = BitmapDescriptor.hueYellow;
      } else if (item.statusUrgent == 'rendah') {
        hue = BitmapDescriptor.hueGreen;
      }

      return Marker(
        markerId: MarkerId(item.idRekomendasi.toString()),
        position: LatLng(item.latitude, item.longitude),
        infoWindow: InfoWindow(title: item.judul, snippet: item.alamat),
        icon: BitmapDescriptor.defaultMarkerWithHue(hue)
      );
    }).toList();

    setState(() {
      markers.addAll(apiMarkers);
    }); 
  }

  @override
  Widget build(BuildContext context) {
    viewMap() {
      return GoogleMap(
        markers: markers,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        minMaxZoomPreference: initialMinMaxZoom(),
        cameraTargetBounds: CameraTargetBounds(
          LatLngBounds(
            southwest: LatLng(0.565224, 103.914942), 
            northeast: LatLng(1.2314551402831757, 104.29134516648656)
        )),
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        mapType: MapType.hybrid,
        initialCameraPosition: initialCameraPosition(),
        gestureRecognizers: {
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
      );
    }

    mapButton() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
          ),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => PetaPersebaran(markers: markers,)));
          },
          icon: SvgPicture.asset('assets/icons/beranda/fullmap.svg'),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        alignment: Alignment.topRight,
        children: [viewMap(), mapButton()],
      ),
    );
  }
}
