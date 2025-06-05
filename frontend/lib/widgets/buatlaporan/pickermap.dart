import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/apiservicemap.dart';
import 'package:frontend/services/geocodmaps.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future pickerMap(BuildContext context) {
  LatLng? pickedLocation;

  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.85,
          child: StatefulBuilder(
            builder: (context, setState) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    GoogleMap(
                      onTap: (LatLng latLng) {
                        setState(() {
                          pickedLocation = latLng;
                        });
                      },
                      markers:
                          pickedLocation != null
                              ? {
                                Marker(
                                  markerId: MarkerId("picked"),
                                  position: pickedLocation!,
                                ),
                              }
                              : {},
                      minMaxZoomPreference: initialMinMaxZoom(),
                      cameraTargetBounds: CameraTargetBounds(
                        LatLngBounds(
                          southwest: LatLng(0.565224, 103.914942),
                          northeast: LatLng(
                            1.2314551402831757,
                            104.29134516648656,
                          ),
                        ),
                      ),
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      mapType: MapType.hybrid,
                      initialCameraPosition: initialCameraPosition(),
                      gestureRecognizers: {
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                    ),
                    if (pickedLocation == null)
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Ketuk pada daerah yang ingin anda pilih',
                            style: TextStyle(
                              fontFamily: 'Instrument-Sans',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    else if (pickedLocation != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                              left: 20,
                              right: 20,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  final alamat = geocodelocation(pickedLocation);
                                  Navigator.pop(context, alamat);
                                },
                                child: Text(
                                  "Pilih Lokasi Ini",
                                  style: TextStyle(
                                    fontFamily: 'Instrument-Sans',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
