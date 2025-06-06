import 'package:flutter/material.dart';
import 'package:frontend/models/model_rekomendasi.dart';
import 'package:frontend/pages/detailrekomendasi.dart';

class CardUrgensi extends StatefulWidget {
  final ModelCardRekomendasi indexrekomen;
  const CardUrgensi({super.key, required this.indexrekomen});

  @override
  State<CardUrgensi> createState() => _CardUrgensiState();
}

class _CardUrgensiState extends State<CardUrgensi> {
  @override
  Widget build(BuildContext context) {
    final dataJenis = widget.indexrekomen.idLaporan.jenis;
    String jenislaporan = '';

    if (dataJenis == 'jalan') {
      jenislaporan = 'Jalan Rusak';
    } else if (dataJenis == 'lampu_jalan') {
      jenislaporan = 'Lampu Jalan';
    } else if (dataJenis == 'jembatan') {
      jenislaporan = 'Jembatan Rusak';
    }

    final dataStatus = widget.indexrekomen.statusUrgent;
    String statusUrgent = '';
    Color warnaUrgent = Color.fromRGBO(202, 213, 226, 1);
    Color teksUrgent = Colors.black;

    if (dataStatus == 'tinggi') {
      statusUrgent = 'Tinggi';
      warnaUrgent = Color.fromRGBO(255, 201, 201, 100);
      teksUrgent = Color.fromRGBO(231, 0, 11, 100);
    } else if (dataStatus == 'sedang') {
      statusUrgent = 'Sedang';
      warnaUrgent = Color.fromRGBO(255, 240, 133, 100);
      teksUrgent = Color.fromRGBO(240, 177, 0, 100);
    } else if (dataStatus == 'rendah') {
      statusUrgent = 'Rendah';
      warnaUrgent = Color.fromRGBO(164, 244, 207, 100);
      teksUrgent = Color.fromRGBO(0, 153, 102, 100);
    } else {
      statusUrgent = 'Tidak Dikenali';
    }

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => DetailRekomendasiScreen(
                  index: widget.indexrekomen.id,
                  alamat: widget.indexrekomen.idLaporan.alamat,
                ),
          ),
        );
      },
      child: Container(
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 104,
                height: 104,
                child: Image.network(
                  widget.indexrekomen.idLaporan.gambar,
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
                        child: Text(
                          widget.indexrekomen.idLaporan.judul,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Instrument-Sans',
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),

                      Row(
                        children: [
                          SizedBox(
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
                            height: 20,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: warnaUrgent,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 2,
                                    bottom: 2,
                                    left: 8,
                                    right: 8,
                                  ),
                                  child: Text(
                                    statusUrgent,
                                    style: TextStyle(
                                      color: teksUrgent,
                                      fontFamily: 'Instrument-Sans',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 1,
                          child: Text(
                            widget.indexrekomen.idLaporan.alamat,
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
      ),
    );
  }
}
