import 'package:flutter/material.dart';
import 'package:balapin/models/model_laporan.dart';

class ListLaporan extends StatefulWidget {
  final ModelCardLaporan? dataCardLaporan;
  const ListLaporan({super.key, required this.dataCardLaporan});

  @override
  State<ListLaporan> createState() => _ListLaporanState();
}

class _ListLaporanState extends State<ListLaporan> {
  @override
  Widget build(BuildContext context) {
    final dataJenis = widget.dataCardLaporan!.jenis;
    String jenislaporan = '';

    if (dataJenis == 'jalan') {
      jenislaporan = 'Jalan Rusak';
    } else if (dataJenis == 'lampu_jalan') {
      jenislaporan = 'Lampu Jalan';
    } else if (dataJenis == 'jembatan') {
      jenislaporan = 'Jembatan Rusak';
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 1,
            spreadRadius: 0.02,
            color: Color.fromRGBO(0, 0, 0, 0.13),
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Color.fromRGBO(202, 213, 226, 1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              clipBehavior: Clip.hardEdge,
              width: 104,
              height: 104,
              child: Image.network(
                widget.dataCardLaporan!.gambar,
                loadingBuilder: (context, child, loadingProgress) {
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
            SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 104,
                child: Column(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color.fromRGBO(223, 234, 255, 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 2,
                              bottom: 2,
                              left: 8,
                              right: 8,
                            ),
                            child: Text(
                              jenislaporan,
                              style: TextStyle(
                                color: Color.fromRGBO(17, 84, 237, 1),
                                fontFamily: 'Instrument-Sans',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 20,
                      child: Text(
                        widget.dataCardLaporan!.judul.toString(),
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Instrument-Sans',
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),

                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 1,
                        child: Text(
                          widget.dataCardLaporan!.deskripsi.toString(),
                          style: TextStyle(
                            fontSize: 8,
                            fontFamily: 'Instrument-Sans',
                            fontWeight: FontWeight.w400,
                          ),
                          softWrap: true,
                          maxLines: null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
