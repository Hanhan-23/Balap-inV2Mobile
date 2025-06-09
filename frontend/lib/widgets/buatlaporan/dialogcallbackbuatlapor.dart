import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Future dialogCallbackBuatLapor(BuildContext context, String typeDialog) {
  var iconAnimation = '';
  var pesan = '';
  if (typeDialog == 'berhasil') {
    iconAnimation = 'assets/icons/dialog/checkanimation.json';
    pesan = 'Laporan berhasil dikirim';
  } else if (typeDialog == 'tidak_lengkap') {
    iconAnimation = 'assets/icons/dialog/alertanimation.json';
    pesan = 'Lengkapi laporan terlebih dahulu';
  } else if (typeDialog == 'gagal') {
    iconAnimation = 'assets/icons/dialog/failedanimation.json';
    pesan = 'Laporan gagal dikirim';
  } else if (typeDialog == 'proses') {
    iconAnimation = 'assets/icons/dialog/processanimation.json';
    pesan = 'Laporan sedang dalam proses';
  } else if (typeDialog == 'draf') {
    iconAnimation = 'assets/icons/dialog/draftanimation.json';
    pesan = 'Laporan berhasil di simpan';
  } else if (typeDialog == 'isi_draf') {
    iconAnimation = 'assets/icons/dialog/alertanimation.json';
    pesan = 'Isi minimal satu kolom untuk menyimpan';
  } else if (typeDialog == 'del_draf') {
    iconAnimation = 'assets/icons/dialog/deletedraftanim.json';
    pesan = 'Draf berhasil dihapus';
  } 

  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                iconAnimation,
                width: 100,
                height: 100,
                fit: BoxFit.contain
              ),
              const SizedBox(height: 16),
              Text(
                pesan,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Instrument-Sans',
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              if (typeDialog != 'proses')
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                    color:Color.fromRGBO(202, 213, 226, 1),
                    width: 1,
                  ), 
                  backgroundColor:
                      Colors
                          .white, 
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Instrument-Sans',
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
