import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:balapin/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Buat laporan dari form', (WidgetTester tester) async {
    app.mainBuatLaporan();
    await tester.pumpAndSettle();

    // Delay awal
    await tester.pump(const Duration(seconds: 3));

    // Tekan tombol ambil gambar (FloatingActionButton dengan SVG icon)
    final ambilGambarButton = find.byWidgetPredicate(
      (widget) =>
          widget is FloatingActionButton &&
          widget.child is Padding &&
          (widget.child as Padding).child is SvgPicture,
    );
    expect(ambilGambarButton, findsOneWidget);
    await tester.tap(ambilGambarButton);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    // Tekan tombol konfirmasi gambar dari modal (gunakan teks tombol)
    // Ganti dengan teks yang sesuai jika tidak "Gunakan Gambar"
    final konfirmasiButton = find.text('Gunakan Gambar');
    expect(konfirmasiButton, findsOneWidget);
    await tester.tap(konfirmasiButton);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

        // Scroll agar semua form terlihat
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    // Isi Judul
    await tester.enterText(find.bySemanticsLabel('Judul'), 'Jalan Rusak Parah');
    await tester.pump(const Duration(seconds: 1));

    // Pilih Jenis (dropdown)
    await tester.tap(find.text('Pilih Jenis'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Jalan').last);
    await tester.pumpAndSettle();

    // Isi Deskripsi
    await tester.enterText(
      find.bySemanticsLabel('Deskripsi'),
      'Jalanan berlubang besar di tengah jalan, membahayakan pengendara.',
    );
    await tester.pump(const Duration(seconds: 1));

    // Scroll agar dropdown cuaca terlihat
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    // Pilih Cuaca
    await tester.tap(find.text('Pilih Cuaca'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cerah').last);
    await tester.pumpAndSettle();

    // Geser slider kerusakan
    final slider = find.byType(Slider);
    await tester.drag(slider, const Offset(200, 0));
    await tester.pump(const Duration(seconds: 1));

    // Tekan tombol Kirim
    await tester.tap(find.text('Kirim'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    // Verifikasi
    expect(find.text('Laporan berhasil dikirim'), findsOneWidget);
  });
}
