import 'dart:io';

import 'package:flutter/material.dart';

class ListDrafLapor extends StatelessWidget {
  final dynamic indexlaporan;
  final Color colorSelected;
  final bool isSelected;

  const ListDrafLapor({
    super.key,
    required this.indexlaporan,
    required this.colorSelected,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    String? pickedImage;
    pickedImage = indexlaporan['gambar'];

    String? jenis;
    if (indexlaporan['jenis'] == 'Jalan') {
      jenis = 'Jalan Rusak';
    } else if (indexlaporan['jenis'] == 'Lampu Jalan') {
      jenis = 'Lampu Jalan';
    } else if (indexlaporan['jenis'] == 'Jembatan') {
      jenis = 'Jembatan';
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
        border: Border.all(width: 1, color: colorSelected),
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
              child:
                  pickedImage != null
                      ? Image.file(File(pickedImage), fit: BoxFit.cover)
                      : Image.asset(
                        'assets/images/logo.png',
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
                              (jenis == null || jenis.isEmpty)
                                  ? 'Tidak ada jenis'
                                  : jenis,
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
                        (indexlaporan['judul'] == null ||
                                indexlaporan['judul'].isEmpty)
                            ? 'Tidak ada judul'
                            : indexlaporan['judul'],
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
                          (indexlaporan['deskripsi'] == null ||
                                  indexlaporan['deskripsi'].isEmpty)
                              ? 'Tidak ada deskripsi'
                              : indexlaporan['deskripsi'],
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
