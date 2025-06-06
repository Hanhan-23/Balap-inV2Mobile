import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/models/model_laporan.dart';
import 'package:frontend/services/apiservicelaporan.dart';
import 'package:frontend/widgets/parsebsondate.dart';
import 'package:frontend/widgets/parsetimeago.dart';
import 'package:frontend/widgets/textwidget.dart';

class DetailLaporanScreen extends StatelessWidget {
  final dynamic idIndex;
  const DetailLaporanScreen({super.key, required this.idIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            child: FutureBuilder<ModelDetailLaporan>(
              future: getDetailLaporan(idIndex),
              builder: (context, snapshot) {
                var listData = snapshot.data;
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Memuat detail laporan');
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Text('Layanan sedang nonaktif mohon maaf');
                } else if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      final dataJenis = listData!.jenis;
                      String jenislaporan = '';

                      if (dataJenis == 'jalan') {
                        jenislaporan = 'Jalan Rusak';
                      } else if (dataJenis == 'lampu_jalan') {
                        jenislaporan = 'Lampu Jalan';
                      } else if (dataJenis == 'jembatan') {
                        jenislaporan = 'Jembatan Rusak';
                      }

                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 17),
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
                            padding: const EdgeInsets.only(bottom: 8),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextWidget(
                                text: listData.judul,
                                colortext: Colors.black,
                                fontsize: 20,
                                fontweight: FontWeight.w500,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextWidget(
                                text:
                                    '${parsebsondate(listData.tglLapor)} (${parsetimeago(listData.tglLapor)})',
                                colortext: Color.fromRGBO(98, 116, 142, 1),
                                fontsize: 14,
                                fontweight: FontWeight.w400,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 19),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              clipBehavior: Clip.hardEdge,
                              width: double.infinity,
                              height:
                                  MediaQuery.of(context).size.height * 0.428,
                              child: Image.network(
                                listData.gambar,
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  return loadingProgress == null
                                      ? child
                                      : CircularProgressIndicator();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      'Gambar tidak tersedia di layanan',
                                      style: TextStyle(
                                        color: Color.fromRGBO(17, 84, 237, 1),
                                        fontFamily: 'Instrument-Sans',
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
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
                                      text: listData.peta.alamat,
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
                            padding: const EdgeInsets.only(bottom: 18),
                            child: SizedBox(
                              width: double.infinity,
                              child: Divider(color: Colors.black),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: TextWidget(
                              text: listData.deskripsi,
                              colortext: Colors.black,
                              fontsize: 14,
                              fontweight: FontWeight.w400,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Text('Maaf kesalahan layanan');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
