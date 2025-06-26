import 'package:flutter/material.dart';
import 'package:balapin/callback/callbackpenggunabaru.dart';
import 'package:balapin/pages/privacy_policy.dart';
import 'package:balapin/provider/laporan_provider.dart';
import 'package:balapin/widgets/navigations/botnav.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetTimeAgo.setDefaultLocale('id');
  final cekpengguna = await checkPenggunaBaru();
  runApp(
    ChangeNotifierProvider(
      create: (_) => LaporanProvider(),
      child: MyApp(cekpengguna: cekpengguna),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool cekpengguna;
  const MyApp({super.key, required this.cekpengguna});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BALAP-IN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Instrument-Sans',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(17, 84, 237, 1),
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('in'), Locale('en')],
      home: cekpengguna ? const PrivacyPolicyPages() : const BottomNavigation(),
    );
  }
}
