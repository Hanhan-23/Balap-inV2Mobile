import 'package:flutter/material.dart';
import 'package:frontend/pages/cara_melapor/informasi_umum.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:frontend/widgets/kustom_widget/gap_y.dart';
import 'package:frontend/widgets/cara_melapor/langkah_pelaporan/card_tutorial_list.dart';
import 'package:frontend/widgets/navigations/botnav.dart';

class LangkahMelaporPages extends StatelessWidget {
  const LangkahMelaporPages ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: PhosphorIcon(
            PhosphorIconsLight.arrowLeft,
            color: Colors.black,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => InformasiUmumPages(),), 
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 28),
          child: Column(
            children: [
              // Bagian atas: header dan deskripsi
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cara melapor',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GapY(12),
                  Text(
                    'Lihat jalan rusak atau lampu mati? Yuk, mulai lapor dengan langkah di bawah ini.',
                    style: TextStyle(
                      color: Color(0XFF1D293D),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  GapY(24),
                ],
              ),
              // Ini yang fleksibel dan bisa scroll
              Expanded(
                child: CardTutorialList(),
              ),
              // Tombol
              GapY(24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0XFF1154ED),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavigation(),), 
                    );
                  },
                  child: const Text(
                    'Buat Laporan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color:Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}