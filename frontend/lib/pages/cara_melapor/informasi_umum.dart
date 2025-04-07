import 'package:flutter/material.dart';
import 'package:frontend/widgets/cara_melapor/informasi_umum/card_list.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:frontend/widgets/kustom_widget/gap_y.dart';

class InformasiUmumPages extends StatelessWidget {
  const InformasiUmumPages ({super.key});

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
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 32, left: 32, right: 32, bottom: 28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // section 1
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // header
                      Text(
                        'Bingung dan takut melapor?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      GapY(12),
                      // deskripsi
                      Text(
                        'BALAP-IN akan membantu menyampaikan keresahanmu dan melindungi identitasmu.',
                        style: TextStyle(
                          color: Color(0XFF1D293D),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  GapY(24),
                  // header
                  Text(
                    'Syarat Pelaporan',
                      style: TextStyle(
                        color: Color(0XFF1D293D),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  GapY(24),
                  // section 2
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CardList(),
                    ],
                  ),
                ],
              ),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0XFF1154ED),
                  ),
                  onPressed: ()
                  {
                    
                  },
                  child: const Text('Lanjut'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}