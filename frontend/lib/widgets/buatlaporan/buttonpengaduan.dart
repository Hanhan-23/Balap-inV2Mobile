import 'package:flutter/material.dart';
import 'package:frontend/provider/laporan_provider.dart';
import 'package:frontend/services/apiservicelaporan.dart';
import 'package:provider/provider.dart';

class ButtonPengaduan extends StatelessWidget {
  final dynamic keyKirim;
  final dynamic keyDraft;
  const ButtonPengaduan({super.key, required this.keyKirim, required this.keyDraft});
  
  @override
  Widget build(BuildContext context) {
    final laporanprovider = context.watch<LaporanProvider>();

    Color colorKirim = Color.fromRGBO(17, 84, 237, 1);
    Color colorDraft = Colors.white;
    Color borderColor = Color.fromRGBO(202, 213, 226, 1);
    String textKirim = 'Kirim';
    String textDraft = 'Draft';
    Color textColorDraft = Colors.black;
    Color textColorKirim = Colors.white;
    
    buttonKirimDraft(colorButton, Color borderColor, String buttonText, Color textcolortext, function) {
      return TextButton(
            style: TextButton.styleFrom(
              overlayColor: Colors.black,
              backgroundColor: colorButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(
                  color: borderColor
                )
              )
            ),
            onPressed: function,
            child: Text(buttonText,
            style: TextStyle(
              fontFamily: 'Instrument-Sans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: textcolortext,
            ),)
          );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          key: keyKirim,
          width: double.infinity,
          height: 52,
          child: buttonKirimDraft(colorKirim, colorKirim, textKirim, textColorKirim, () => buatLapor(laporanprovider.gambar ,laporanprovider.judul, laporanprovider.jenis, laporanprovider.deskripsi, laporanprovider.cuaca, laporanprovider.nilaikerusakan, laporanprovider.pickedLocation))
        ),

        SizedBox(
          key: keyDraft,
          width: double.infinity,
          height: 52,
          child: buttonKirimDraft(colorDraft, borderColor, textDraft, textColorDraft, () => buatLapor(null ,'draft', 'sss', 'ddd', 'sss', 2.0, null))
        ),
      ],
    );
  }
}