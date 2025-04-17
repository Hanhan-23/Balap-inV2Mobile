// DALAM PENGEMBANGAN (BELUM DIIMPLEMENTASIKAN)

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkBuatLaporan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? buatLaporanValid = prefs.getBool('buatLaporanValid');

    if (buatLaporanValid == null || buatLaporanValid == true) {
        return true;
    } else {
        return false;
    }
}

Future<void> validBuatLaporan() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('buatLaporanValid', false);
}