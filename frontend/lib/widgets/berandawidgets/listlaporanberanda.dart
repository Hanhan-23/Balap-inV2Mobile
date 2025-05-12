import 'package:flutter/material.dart';
import 'package:frontend/models/model_laporan.dart';
import 'package:frontend/pages/detaillaporan.dart';
import 'package:frontend/services/apiservicelaporan.dart';
import 'package:frontend/widgets/berandawidgets/listlaporan/headerlistlapor.dart';
import 'package:frontend/widgets/berandawidgets/listlaporan/listlaporan.dart';

class ListLaporanBeranda extends StatefulWidget {
  const ListLaporanBeranda({super.key});

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
          child: HeaderListLapor(),
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
                  future: getCardLaporan(),
                  builder: (context, snapshot) {
                    var listData = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listData!.length,
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
                            child: ListLaporan(
                              dataCardLaporan: listData[index],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Text('Sedang menyediakan layanan mohon menunggu');
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
