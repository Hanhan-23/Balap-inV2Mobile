import 'package:flutter/material.dart';
import 'package:frontend/provider/laporan_provider.dart';
import 'package:frontend/services/apiservicelaporan.dart';
import 'package:provider/provider.dart';
import 'dialogcallbackbuatlapor.dart';

class ButtonPengaduan extends StatelessWidget {
  final dynamic keyKirim;
  final dynamic keyDraft;

  const ButtonPengaduan({
    super.key,
    required this.keyKirim,
    required this.keyDraft,
  });

  @override
  Widget build(BuildContext context) {
    final laporanProvider = context.watch<LaporanProvider>();

    Color colorKirim = const Color.fromRGBO(17, 84, 237, 1);
    Color colorDraft = Colors.white;
    Color borderColor = const Color.fromRGBO(202, 213, 226, 1);
    String textKirim = 'Kirim';
    String textDraft = 'Draft';
    Color textColorDraft = Colors.black;
    Color textColorKirim = Colors.white;

    Widget buttonKirimDraft(
      Color colorButton,
      Color borderColor,
      String buttonText,
      Color textColor,
      VoidCallback? onPressed,
    ) {
      return TextButton(
        style: TextButton.styleFrom(
          overlayColor: Colors.black12,
          backgroundColor: colorButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(color: borderColor),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontFamily: 'Instrument-Sans',
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: textColor,
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          key: keyKirim,
          width: double.infinity,
          height: 52,
          child: buttonKirimDraft(
            colorKirim,
            colorKirim,
            textKirim,
            textColorKirim,
            () async {
              final isValid = await handleLaporan(
                laporanProvider.gambar,
                laporanProvider.judul,
                laporanProvider.jenis,
                laporanProvider.deskripsi,
                laporanProvider.cuaca,
                laporanProvider.nilaikerusakan,
                laporanProvider.pickedLocation,
              );

              if (isValid) {
                dialogCallbackBuatLapor(context, 'proses');

                final buatlapor = await buatLapor(
                  laporanProvider.gambar,
                  laporanProvider.judul,
                  laporanProvider.jenis,
                  laporanProvider.deskripsi,
                  laporanProvider.cuaca,
                  laporanProvider.nilaikerusakan,
                  laporanProvider.pickedLocation,
                );

                Navigator.of(context).pop();

                dialogCallbackBuatLapor(context, buatlapor);
              } else {
                dialogCallbackBuatLapor(context, 'tidak_lengkap');
              }
            },
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          key: keyDraft,
          width: double.infinity,
          height: 52,
          child: buttonKirimDraft(
            colorDraft,
            borderColor,
            textDraft,
            textColorDraft,
            () async {
              final isValid = await handleDraftLaporan(
                laporanProvider.gambar,
                laporanProvider.judul,
                laporanProvider.jenis,
                laporanProvider.deskripsi,
                laporanProvider.cuaca,
                laporanProvider.nilaikerusakan,
                laporanProvider.pickedLocation,
              );

              if (isValid) {
                await buatLapor(
                  laporanProvider.gambar,
                  laporanProvider.judul,
                  laporanProvider.jenis,
                  laporanProvider.deskripsi,
                  laporanProvider.cuaca,
                  laporanProvider.nilaikerusakan,
                  laporanProvider.pickedLocation,
                );
              } else {
                dialogCallbackBuatLapor(context, 'isi_draf');
              }
            },
          ),
        ),
      ],
    );
  }
}
