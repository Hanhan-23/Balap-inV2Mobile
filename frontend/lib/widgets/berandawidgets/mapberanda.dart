import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/pages/petapersebaran.dart';
import 'package:frontend/services/apiservicemap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapBeranda extends StatefulWidget {
  const MapBeranda({super.key});

  @override
  State<MapBeranda> createState() => _MapBerandaState();
}

class _MapBerandaState extends State<MapBeranda> {
  @override
  Widget build(BuildContext context) {

    viewMap() {
      return GoogleMap(
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
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
            MaterialPageRoute(builder: (context) => PetaPersebaran()));
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
