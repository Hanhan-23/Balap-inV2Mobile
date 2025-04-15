import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkPenggunaBaru() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? penggunabaruvalid = prefs.getBool('penggunabaru');

  if (penggunabaruvalid == null || penggunabaruvalid == true) {
    return true; 
  } else {
    return false;
  }
}

Future<bool> setujuPenggunaBaru() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool('penggunabaru', false);
}
