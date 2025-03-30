import 'package:flutter/material.dart';
import 'package:frontend/widgets/buatlaporan/appbarbuatlapor.dart';

class BuatLaporanPages extends StatelessWidget {
  const BuatLaporanPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBuatLapor()
    );
  }
}