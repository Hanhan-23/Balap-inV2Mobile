import 'package:flutter/material.dart';
import 'package:frontend/widgets/area_urgensi/card_urgensi.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:frontend/widgets/area_urgensi/filter_chip.dart';

class RekomendasiUrgensiPages extends StatelessWidget {
  const RekomendasiUrgensiPages({super.key});

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
        title: const Text('Area Urgensi'),
      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.045),  
      child: Column(
        children: [
          FilterUrgensi(),

          // List scrollable card
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10, // ganti sesuai jumlah datamu
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: CardUrgensi(), // komponen kartu kamu
                );
              },
            ),)
        ],
      ),
      )
    );
  }
}
