import 'package:intl/intl.dart';

parsebsondate(String tgl) {
  if (tgl.isNotEmpty) {
    final tglmills = int.tryParse(tgl);

    final date = DateTime.fromMillisecondsSinceEpoch(tglmills!);
    final formatted = DateFormat('dd MMMM yyyy', 'id_ID').format(date);

    return formatted;
  } else {
    return 'Tidak ada tanggal';
  }
}
