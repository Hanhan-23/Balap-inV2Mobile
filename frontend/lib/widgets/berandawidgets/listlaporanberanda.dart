import 'package:flutter/material.dart';
import 'package:balapin/models/model_laporan.dart';
import 'package:balapin/pages/detaillaporan.dart';
import 'package:balapin/widgets/berandawidgets/listlaporan/headerlistlapor.dart';
import 'package:balapin/widgets/berandawidgets/listlaporan/listlaporan.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ListLaporanBeranda extends StatefulWidget {
  final Function(int) filterindex;
  final Future<List<ModelCardLaporan>> laporanFuture;

  const ListLaporanBeranda({
    super.key,
    required this.laporanFuture,
    required this.filterindex,
  });

  @override
  State<ListLaporanBeranda> createState() => _ListLaporanBerandaState();
}

class _ListLaporanBerandaState extends State<ListLaporanBeranda> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 0.08,
          child: HeaderListLapor(
            onFilterChanged: (int filter) {
              setState(() {
                widget.filterindex(filter);
              });
            },
          ),
        ),
        SizedBox(height: 14),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Column(
              spacing: 8,
              children: [
                FutureBuilder<List<ModelCardLaporan>>(
                  future: widget.laporanFuture,
                  builder: (context, snapshot) {
                    var listData = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (listData!.length == 0) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 10),
                            Icon(PhosphorIconsBold.fileX),
                            Text(
                              'Belum ada laporan saat ini',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      } else {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => DetailLaporanScreen(
                                          idIndex: listData[index].id,
                                        ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: ListLaporan(
                                  dataCardLaporan: listData[index],
                                ),
                              ),
                            );
                          },
                        );
                      }
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
                    } else if (snapshot.connectionState !=
                        ConnectionState.none) {
                      return Text('Layanan sedang nonaktif mohon maaf');
                    } else {
                      return Text('Kesalahan layanan');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
