import 'package:flutter/material.dart';
import 'package:frontend/widgets/buatlaporan/alamatpengaduan.dart';
import 'package:frontend/widgets/buatlaporan/ambilgambar.dart';
import 'package:frontend/widgets/buatlaporan/appbarbuatlapor.dart';
import 'package:frontend/widgets/buatlaporan/buttonpengaduan.dart';
import 'package:frontend/widgets/buatlaporan/cuacapengaduan.dart';
import 'package:frontend/widgets/buatlaporan/deskripsipengaduan.dart';
import 'package:frontend/widgets/buatlaporan/judulpengaduan.dart';
import 'package:frontend/widgets/buatlaporan/nilaikerusakan.dart';

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
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              AmbilGambar(),
              SizedBox(height: 12,),
              SizedBox(
                width: double.infinity,
                height: 78,
                child: Judulpengaduan()
              ),   

              SizedBox(height: 14,),   
              SizedBox(
                width: double.infinity,
                height: 176,
                child: DeskripsiPengaduan()
              ),

              SizedBox(height: 14,), 
              SizedBox(
                width: double.infinity,
                height: 78,
                child: CuacaPengaduan()
              ),

              SizedBox(height: 14,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: NilaiKerusakan()
              ),

              SizedBox(height: 14,),
              SizedBox(
                width: double.infinity,
                height: 94,
                child: AlamatPengaduan()
              ),

              SizedBox(height: 40,),
              SizedBox(
                width: double.infinity,
                height: 118,
                child: ButtonPengaduan()
              ),
              SizedBox(height: 14,),
            ],
          ),
        ),
      ),
    );
  }
}