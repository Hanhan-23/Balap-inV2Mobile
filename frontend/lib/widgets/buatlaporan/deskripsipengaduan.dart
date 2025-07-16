import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:balapin/provider/laporan_provider.dart';
import 'package:provider/provider.dart';

class DeskripsiPengaduan extends StatefulWidget {
  const DeskripsiPengaduan({super.key});

  @override
  State<DeskripsiPengaduan> createState() => _DeskripsiPengaduanState();
}

class _DeskripsiPengaduanState extends State<DeskripsiPengaduan> {
  final TextEditingController deskripsiController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final laporanProvider = context.watch<LaporanProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Deskripsi Pengaduan',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Instrument-Sans',
            fontWeight: FontWeight.w400,
            fontSize: 14
          ),
        ),
        
        SizedBox(
          height: 150,
          child: TextField(
            key: const Key("deskripsi_form"),
            controller: laporanProvider.deskripsiController,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'[\n\r]'))
            ],
            cursorColor: Color(0XFF1154ED),
            textAlignVertical: TextAlignVertical.top,
            expands: true,
            maxLength: 120,
            maxLines: null,
            style: TextStyle(
              fontFamily: 'Instrument-Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(46, 55, 68, 1)
            ),
            decoration: InputDecoration(
              counterText: '',
              hintText: 'Jalan berlubang penyebab kecelakaan motor kemarin sore dan sudah satu bulan belum diperbaiki sama sekali',
              hintStyle: TextStyle(
                fontFamily: 'Instrument-Sans',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color.fromRGBO(98, 116, 142, 1)
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(202, 213, 226, 1)
                ),
                borderRadius: BorderRadius.circular(12)
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromRGBO(142, 153, 167, 1)
                ),
                borderRadius: BorderRadius.circular(12)
              ),

              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(206, 128, 128, 1)
                ),
                borderRadius: BorderRadius.circular(12)
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromRGBO(204, 76, 76, 1)
                ),
                borderRadius: BorderRadius.circular(12)
              )
              
            ),
          ),
        )
      ],
    );
  }
}