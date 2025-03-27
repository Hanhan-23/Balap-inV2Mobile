import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnalisisBeranda extends StatefulWidget {
  const AnalisisBeranda({super.key});

  @override
  State<AnalisisBeranda> createState() => _AnalisisBerandaState();
}



class _AnalisisBerandaState extends State<AnalisisBeranda> {
  @override
  Widget build(BuildContext context) {

    Widget containerAnalisis(icon, text, texttwo) {
      return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color.fromRGBO(202, 213, 226, 100)
            )
          ),
          width: MediaQuery.of(context).size.width * 0.425,
          height: double.infinity,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.028,
              bottom: MediaQuery.of(context).size.height * 0.028,
              right: MediaQuery.of(context).size.width * 0.028,
              left: MediaQuery.of(context).size.width * 0.028,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(223, 234, 255, 100),
                    borderRadius: BorderRadius.circular(100),
                  ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: SvgPicture.asset(icon),
                ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: Text(text,
                    style: TextStyle(
                      fontFamily: 'Instrument-Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 10
                    ),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: Text(texttwo,
                    style: TextStyle(
                      fontFamily: 'Instrument-Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(2, 54, 156, 1)
                    ),
                  ),
                ),

              ],
            ),
          )
        );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        containerAnalisis('assets/icons/beranda/files.svg', 'Jumlah Laporan', '208'),
        containerAnalisis('assets/icons/beranda/megaphone.svg', 'Keluhan Dominan', 'Jalan Rusak')
      ],
    );
  }
}