import 'package:balapin/services/apiservicemasyarakat.dart';
import 'package:flutter/material.dart';
import 'package:balapin/callback/callbackpenggunabaru.dart';
import 'package:balapin/pages/privacy_policy.dart';
import 'package:balapin/provider/laporan_provider.dart';
import 'package:balapin/widgets/navigations/botnav.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  _showNotification(message);
}

Future<Position> getCurrentPosition() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled.');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are denied.');
    }
  }

  return await Geolocator.getCurrentPosition(
    locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
  );
}

void _showNotification(RemoteMessage message) async {
  const androidDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'Notifikasi Prioritas',
    importance: Importance.max,
    priority: Priority.high,
  );

  const platformDetails = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? 'Notifikasi',
    message.notification?.body ?? '',
    platformDetails,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Izin notifikasi (Android 13+)
  await FirebaseMessaging.instance.requestPermission();
  try {
    await getCurrentPosition();
  } catch (e) {
    debugPrint("Gagal mendapatkan lokasi: $e");
  }

  // Subscribe ke topik
  await FirebaseMessaging.instance.subscribeToTopic('global_notifications');

  // Inisialisasi notifikasi lokal
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: androidInit);
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  // Background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // GetTimeAgo
  GetTimeAgo.setDefaultLocale('id');

  bool cekpengguna = false;

  try {
    cekpengguna = await checkPenggunaBaru();
  } catch (e) {
    debugPrint("Gagal mengecek pengguna baru: $e");
  }

  try {
    final token = await checkAkunMasyarakat();
    if (token == null) {
      debugPrint("Token akun masyarakat null. Akun mungkin gagal dibuat.");
    }
  } catch (e) {
    debugPrint("Gagal cek atau buat akun masyarakat: $e");
  }

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
    // Foreground listener (notif saat app aktif)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });

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
