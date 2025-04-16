import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:frontend/widgets/Notifikasi/card_notifikasi.dart';
import 'package:frontend/widgets/kustom_widget/gap_y.dart';

class NotifikasiPages extends StatelessWidget {
  const NotifikasiPages({super.key});

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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child:
              Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.045),  
      child:
          // List scrollable card
        ListView(
          padding: EdgeInsets.only(top: 24,),
          physics: const BouncingScrollPhysics(),
            children: [
                CardNotifikasi(),
                GapY(12),
                CardNotifikasi(),
                GapY(12),
                CardNotifikasi(),
                GapY(12),
                CardNotifikasi(),
                GapY(12),
                CardNotifikasi(),
                GapY(12),
                CardNotifikasi(),
              ],
            ),
        ),
      )
    );
  }
}