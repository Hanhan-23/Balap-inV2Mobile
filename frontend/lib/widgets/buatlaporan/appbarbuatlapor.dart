import 'package:flutter/material.dart';
import 'package:frontend/widgets/navigations/botnav.dart';

class AppBarBuatLapor extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBuatLapor({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () {
             Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
          );
        }, icon: Icon(Icons.arrow_back,
          weight: 0.5,
          size: 30,
        )
      ),
      title: const Text('Buat Laporan',
        style: TextStyle(
          fontFamily: 'instrument-Sans',
          color: Colors.black,
          fontWeight: FontWeight.w700
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}