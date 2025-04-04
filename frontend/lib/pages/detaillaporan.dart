import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/widgets/navigations/botnav.dart';

class DetailLaporanScreen extends StatelessWidget {
  const DetailLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    textWidget(String text, Color colortext, double fontsize, fontweight) {
      return Text(
        text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: colortext,
          fontFamily: 'Instrument-Sans',
          fontSize: fontsize,
          fontWeight: fontweight,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
            );
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
            child: ListView(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 17),
                      child: SizedBox(
                        width: double.infinity,
                        child: textWidget(
                          'Jalan Rusak',
                          Colors.black,
                          12,
                          FontWeight.w400,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: textWidget(
                          'Jalan di simpang lampu merah berlubang',
                          Colors.black,
                          20,
                          FontWeight.w500,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SizedBox(
                        width: double.infinity,
                        child: textWidget(
                          '12 Maret 2025 (sehari lalu)',
                          Color.fromRGBO(98, 116, 142, 1),
                          14,
                          FontWeight.w400,
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
                        height: MediaQuery.of(context).size.height * 0.428,
                        child: Image.asset(
                          'assets/images/logo.png',
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
                              child: textWidget(
                                'Jl. Ahmad Yani, Kabil, Kecamatan Nongsa, Kota Batam, Kepulauan Riau 29444',
                                Colors.black,
                                14,
                                FontWeight.w400,
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
                      child: textWidget(
                        'Jalan berlubang penyebab kecelakaan motor kemarin sore dan sudah satu bulan belum diperbaiki sama sekali',
                        Colors.black,
                        14,
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
