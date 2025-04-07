import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/widgets/berandawidgets/listlaporan/dialogfilterlap.dart';

class HeaderListLapor extends StatefulWidget {
  const HeaderListLapor({super.key});

  @override
  State<HeaderListLapor> createState() => _HeaderListLaporState();
}

class _HeaderListLaporState extends State<HeaderListLapor> {
  @override
  Widget build(BuildContext context) {
    dialogFilter() {
      return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => DialogFilterLaporan()
      );
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
          child: const Text.rich(
            TextSpan(
              text: 'Diurutkan berdasarkan: ',
              style: TextStyle(
                color: Color.fromRGBO(98, 116, 142, 1),
                fontFamily: 'Instrument-Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Seminggu terakhir',
                  style: TextStyle(
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
