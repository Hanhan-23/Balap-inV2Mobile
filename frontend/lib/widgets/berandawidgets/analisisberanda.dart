import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:balapin/models/model_laporan.dart';

class AnalisisBeranda extends StatefulWidget {
  final Future<List<ModelCardLaporan>> laporanFuture;

  const AnalisisBeranda({super.key, required this.laporanFuture});

  @override
  State<AnalisisBeranda> createState() => _AnalisisBerandaState();
}

class _AnalisisBerandaState extends State<AnalisisBeranda> {
  String _formatJenis(String jenis) {
    switch (jenis) {
      case 'jalan':
        return 'Jalan Rusak';
      case 'lampu_jalan':
        return 'Lampu Jalan';
      case 'jembatan':
        return 'Jembatan';
      default:
        return jenis;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget containerAnalisis(icon, text, texttwo) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color.fromRGBO(202, 213, 226, 1)),
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
                child: Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Instrument-Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                child: Text(
                  texttwo,
                  style: TextStyle(
                    fontFamily: 'Instrument-Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(2, 54, 156, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return FutureBuilder<List<ModelCardLaporan>>(
      future: widget.laporanFuture,
      builder: (context, snapshot) {
        String jumlahLaporan = '0';
        String keluhanDominan = '-';

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final data = snapshot.data!;

          jumlahLaporan = data.length.toString();

          final jenisCount = <String, int>{};

          for (var laporan in data) {
            jenisCount[laporan.jenis] = (jenisCount[laporan.jenis] ?? 0) + 1;
          }

          if (jenisCount.isNotEmpty) {
            final sorted =
                jenisCount.entries.toList()
                  ..sort((a, b) => b.value.compareTo(a.value));

            keluhanDominan = _formatJenis(sorted.first.key);
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          jumlahLaporan = '...';
          keluhanDominan = '...';
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            containerAnalisis(
              'assets/icons/beranda/files.svg',
              'Jumlah Laporan',
              jumlahLaporan,
            ),
            containerAnalisis(
              'assets/icons/beranda/megaphone.svg',
              'Keluhan Dominan',
              keluhanDominan,
            ),
          ],
        );
      },
    );
  }
}
