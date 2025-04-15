import 'package:shared_preferences/shared_preferences.dart';

Future<bool> checkCoachmarkPengguna() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? coachMarkValid = prefs.getBool('coachmark');

  if (coachMarkValid == null || coachMarkValid == false) {
    return true;
  } else {
    return false;
  }

}

Future initCoachPenggunaLama() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('coachmark', true);
}