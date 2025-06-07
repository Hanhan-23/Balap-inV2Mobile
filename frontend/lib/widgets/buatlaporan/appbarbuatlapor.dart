import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/pages/draflapor.dart';
import 'package:frontend/provider/laporan_provider.dart';
import 'package:frontend/widgets/navigations/botnav.dart';
import 'package:provider/provider.dart';

class AppBarBuatLapor extends StatelessWidget implements PreferredSizeWidget {
  final dynamic keyDialogDraft;
  const AppBarBuatLapor({super.key, required this.keyDialogDraft});

  @override
  Widget build(BuildContext context) {
    final laporanprovider = context.watch<LaporanProvider>();

    return AppBar(
      centerTitle: true,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () {
             Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavigation()),
          );
          laporanprovider.clearLaporan();
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
              key: keyDialogDraft,
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  context: context, 
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: const DrafLaporScreen()
                  )
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