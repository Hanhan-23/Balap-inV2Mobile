import 'package:get_time_ago/get_time_ago.dart';

String parsetimeago(String dates) {
  if (dates.isEmpty) return 'Yang lalu';

  final tglmills = int.tryParse(dates);
  if (tglmills == null) return 'Yang lalu';

  final date = DateTime.fromMillisecondsSinceEpoch(tglmills);
  final now = DateTime.now();

  final difference = now.difference(date);

  if (difference.inDays > 365) {
    return 'Lebih dari setahun yang lalu';
  } else if (difference.inDays > 32) {
    return 'Lebih dari sebulan yang lalu';
  } else if (difference.inDays > 8) {
    return 'Lebih dari seminggu yang lalu';
  }

  return GetTimeAgo.parse(date, locale: 'id');
}
