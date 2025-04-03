import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/pages/draflapor.dart';
import 'package:frontend/widgets/navigations/botnav.dart';

class AppBarBuatLapor extends StatelessWidget implements PreferredSizeWidget {
  const AppBarBuatLapor({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () {
             Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
          );
        }, icon: SvgPicture.asset('assets/icons/buatlaporan/arrowleft.svg',
        width: 32,
        height: 32,)
      ),
      title: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Buat Laporan',
              style: TextStyle(
                fontFamily: 'instrument-Sans',
                color: Colors.black,
                fontWeight: FontWeight.w700
              ),
            ),
        
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context, 
                  builder: (context) => const DrafLaporScreen()
                );
              }, 
              icon: SvgPicture.asset('assets/icons/buatlaporan/folders.svg')
            )

          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}