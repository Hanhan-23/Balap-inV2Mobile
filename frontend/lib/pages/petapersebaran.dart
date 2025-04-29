import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/services/apiservicemap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PetaPersebaran extends StatelessWidget {
  const PetaPersebaran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/buatlaporan/arrowleft.svg',
            width: 32,
            height: 32,
          ),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Peta Persebaran',
                style: TextStyle(
                  fontFamily: 'instrument-Sans',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),

      body: GoogleMap(
        cameraTargetBounds: CameraTargetBounds(
          LatLngBounds(
            southwest: LatLng(0.565224, 103.914942), 
            northeast: LatLng(1.2314551402831757, 104.29134516648656)
        )),
        minMaxZoomPreference: initialMinMaxZoom(),
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.hybrid,
        initialCameraPosition: initialCameraPosition(),
        gestureRecognizers: {
          Factory<OneSequenceGestureRecognizer>(
            () => EagerGestureRecognizer(),
          ),
        },
      )
    );
  }
}
