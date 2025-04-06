import 'package:flutter/material.dart';
import 'package:frontend/widgets/navigations/botnav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BALAP-IN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Instrument-Sans',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(17, 84, 237, 1)),
      ),
      home: const BottomNavigation(),
    );
  }
}
