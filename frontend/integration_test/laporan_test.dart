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

    await tester.pump(const Duration(seconds: 3));

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

    final konfirmasiButton = find.text('Galeri');
    expect(konfirmasiButton, findsOneWidget);
    await tester.tap(konfirmasiButton);
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    await tester.pump(const Duration(seconds: 3));

    await tester.drag(find.byType(ListView), const Offset(0, -280));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    await tester.pump(const Duration(seconds: 3));

    await tester.enterText(find.byType(TextField).at(0), 'Jalan ini sudah berlubang parah');
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('Pilih Jenis'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Jalan').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(1), 'Jalanan berlubang besar di tengah jalan, membahayakan pengendara.');
    await tester.pump(const Duration(seconds: 1));

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pumpAndSettle();

    await tester.pump(const Duration(seconds: 3));

    await tester.tap(find.text('Pilih cuaca'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cerah').last);
    await tester.pumpAndSettle();

    final slider = find.byType(Slider);
    await tester.drag(slider, const Offset(200, 0));
    await tester.pump(const Duration(seconds: 1));

    await tester.pump(const Duration(seconds: 2));
    await tester.tap(find.text('Edit Lokasi'));
    await tester.pump(const Duration(seconds: 6));

    await Future.delayed(const Duration(seconds: 10));

    await tester.tap(find.text('Pilih Lokasi'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Kirim'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Laporan berhasil dikirim'), findsOneWidget);
  });
}
