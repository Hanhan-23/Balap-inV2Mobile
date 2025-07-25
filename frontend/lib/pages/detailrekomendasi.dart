import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:balapin/models/model_rekomendasi.dart';
import 'package:balapin/pages/detaillaporan.dart';
import 'package:balapin/services/apiservicerekomendasi.dart';
import 'package:balapin/widgets/berandawidgets/listlaporan/listlaporan.dart';
import 'package:balapin/widgets/textwidget.dart';
import 'package:lottie/lottie.dart';

class DetailRekomendasiScreen extends StatelessWidget {
  final dynamic index;
  final String alamat;
  const DetailRekomendasiScreen({super.key, required this.index, required this.alamat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),

      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Scrollbar(
            child: FutureBuilder<ModelDetailRekomendasi>(
              future: getDetailRekomendasi(index),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  var listData = snapshot.data;

                  final dataJenis = listData!.laporanList.first.jenis;
                  String jenislaporan = '';

                  final status = listData.laporanList.first.status;

                  if (dataJenis == 'jalan') {
                    jenislaporan = 'Jalan Rusak';
                  } else if (dataJenis == 'lampu_jalan') {
                    jenislaporan = 'Lampu Jalan';
                  } else if (dataJenis == 'jembatan') {
                    jenislaporan = 'Jembatan Rusak';
                  }

                  String judullaporanpertama = '';
                  if (status == 'selesai') {
                    judullaporanpertama = listData.laporanList.first.judul;
                  } else if (status == 'disembunyikan') {
                    judullaporanpertama = 'Judul laporan disembunyikan';
                  }
                  
                  return ListView(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextWidget(
                                text: jenislaporan,
                                colortext: Colors.black,
                                fontsize: 12,
                                fontweight: FontWeight.w400,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextWidget(
                                text: judullaporanpertama,
                                colortext: Colors.black,
                                fontsize: 20,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: SizedBox(
                              width: double.infinity,
                              child: Row(
                                spacing: 4,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromRGBO(202, 213, 226, 1),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(11),
                                      child: SvgPicture.asset(
                                        'assets/icons/map-pin.svg',
                                        colorFilter: ColorFilter.mode(
                                          Color.fromRGBO(17, 84, 237, 1),
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: TextWidget(
                                      text:
                                          alamat,
                                      colortext: Colors.black,
                                      fontsize: 14,
                                      fontweight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextWidget(
                                text: 'Dokumentasi',
                                colortext: Colors.black,
                                fontsize: 20,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                          ),

                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: List.generate(
                                listData.laporanList.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      if (listData.laporanList[index].status == 'selesai') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => DetailLaporanScreen(
                                                idIndex: listData.laporanList[index].id,
                                              ),
                                        ),
                                      );
                                      } else {
                                        Container();
                                      }
                                    },
                                    child: ListLaporan
                                    (dataCardLaporan: listData.laporanList[index])
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                                        return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Lottie.asset(
                              'assets/icons/dialog/loadinganimation.json',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      );
                } else if (snapshot.connectionState != ConnectionState.none) {
                  return Text('Layanan sedang nonaktif mohon maaf');
                } else {
                  return Text('Kesalahan layanan');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
