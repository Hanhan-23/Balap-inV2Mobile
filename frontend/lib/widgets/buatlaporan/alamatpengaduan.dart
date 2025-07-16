import 'package:balapin/provider/laporan_provider.dart';
import 'package:balapin/services/geocodmaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:balapin/widgets/buatlaporan/pickermap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AlamatPengaduan extends StatefulWidget {
  const AlamatPengaduan({super.key});

  @override
  State<AlamatPengaduan> createState() => _AlamatPengaduanState();
}
class _AlamatPengaduanState extends State<AlamatPengaduan> {
  String? selectedAddress;
  LatLng? lastLocation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final laporanProvider = Provider.of<LaporanProvider>(context);

    final currentLocation = laporanProvider.pickedLocation;

    if (currentLocation != null &&
        (lastLocation == null ||
            currentLocation.latitude != lastLocation!.latitude ||
            currentLocation.longitude != lastLocation!.longitude)) {
      lastLocation = currentLocation;
      geocodelocation(currentLocation).then((alamat) {
        if (mounted) {
          setState(() {
            selectedAddress = alamat;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Alamat',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Instrument-Sans',
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: () async {
                final laporanProvider =
                    Provider.of<LaporanProvider>(context, listen: false);
                final address = await pickerMap(context);
                if (address != null) {
                  laporanProvider.setPickedLocation(address);
                }
              },
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/buatlaporan/pencil-simple.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                        Color.fromRGBO(2, 54, 156, 1), BlendMode.srcIn),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Edit Lokasi',
                    style: TextStyle(
                      color: Color.fromRGBO(2, 54, 156, 1),
                      fontFamily: 'Instrument-Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 70,
          child: TextFormField(
            key: const Key('alamat_form'),
            cursorColor: const Color(0XFF1154ED),
            readOnly: true,
            textAlignVertical: TextAlignVertical.top,
            expands: true,
            maxLength: 40,
            maxLines: null,
            style: const TextStyle(
              fontFamily: 'Instrument-Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(46, 55, 68, 1),
            ),
            decoration: InputDecoration(
              counterText: '',
              hintText: selectedAddress ?? 'Pilih lokasi infrastruktur',
              hintStyle: const TextStyle(
                fontFamily: 'Instrument-Sans',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color.fromRGBO(98, 116, 142, 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromRGBO(202, 213, 226, 1),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromRGBO(142, 153, 167, 1),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromRGBO(206, 128, 128, 1),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromRGBO(204, 76, 76, 1),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        )
      ],
    );
  }
}