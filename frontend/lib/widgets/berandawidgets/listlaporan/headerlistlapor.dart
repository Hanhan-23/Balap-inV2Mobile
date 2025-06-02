import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/widgets/berandawidgets/listlaporan/dialogfilterlap.dart';

class HeaderListLapor extends StatefulWidget {
  const HeaderListLapor({super.key});

  @override
  State<HeaderListLapor> createState() => _HeaderListLaporState();
}

class _HeaderListLaporState extends State<HeaderListLapor> {
  String berdasarkan = 'Seminggu Terakhir';
  @override
  Widget build(BuildContext context) {
    dialogFilter() async {
      final filterBerdasarkan = await showModalBottomSheet(
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context,
        builder: (context) => DialogFilterLaporan(),
      );

      if (filterBerdasarkan != null) {
        setState(() {
          if (filterBerdasarkan == 1) {
            berdasarkan = 'Seminggu Terakhir';
          } else if (filterBerdasarkan == 2) {
            berdasarkan = 'Sebulan Terakhir';
          } else if (filterBerdasarkan == 3) {
            berdasarkan = 'Setahun Terakhir';
          } else if (filterBerdasarkan == 4) {
            berdasarkan = 'Semua Periode';
          }
        });
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Laporan',
                style: TextStyle(
                  fontFamily: 'Instrument-Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              GestureDetector(
                onTap: () {
                  dialogFilter();
                },
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: SvgPicture.asset('assets/icons/beranda/filter.svg'),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          child: Text.rich(
            TextSpan(
              text: 'Diurutkan berdasarkan: ',
              style: const TextStyle(
                color: Color.fromRGBO(98, 116, 142, 1),
                fontFamily: 'Instrument-Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: berdasarkan,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Instrument-Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
