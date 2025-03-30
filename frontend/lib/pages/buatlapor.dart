import 'package:flutter/material.dart';
import 'package:frontend/widgets/buatlaporan/ambilgambar.dart';
import 'package:frontend/widgets/buatlaporan/appbarbuatlapor.dart';
import 'package:frontend/widgets/buatlaporan/judulpengaduan.dart';

class BuatLaporanPages extends StatelessWidget {
  const BuatLaporanPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarBuatLapor(),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.92,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              AmbilGambar(),
              SizedBox(height: 12,),
              Judulpengaduan()        
            ],
          ),
        ),
      ),
    );
  }
}