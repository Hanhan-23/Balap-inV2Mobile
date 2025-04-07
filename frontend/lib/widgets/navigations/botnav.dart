import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
// import 'package:frontend/pages/beranda.dart';
import 'package:frontend/pages/buatlapor.dart';
import 'package:frontend/pages/cara_melapor/langkah_melapor.dart';
// import 'package:frontend/pages/cara_melapor/informasi_umum.dart';
// import 'package:frontend/pages/detaillaporan.dart';
import 'package:frontend/pages/detailrekomendasi.dart';
// import 'package:frontend/pages/notifikasi.dart';
// import 'package:frontend/pages/privacy_policy.dart';
import 'package:frontend/pages/rekomendasi_urgensi.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedPage = 0;
  final PageController _pageController = PageController();

  final List<Widget> pages = [
    const LangkahMelaporPages(),
    const BuatLaporanPages(),
    const RekomendasiUrgensiPages(),
    const DetailRekomendasiScreen(),
  ];

  List<TabItem> items = [
    TabItem(
      icon: IconData(0xe903, fontFamily: 'CustomIconsBotNav'),
      title: 'Beranda',
    ),
    TabItem(
      icon: IconData(0xe901, fontFamily: 'CustomIconsBotNav'),
      title: 'Lapor',
    ),
    TabItem(
      icon: IconData(0xe900, fontFamily: 'CustomIconsBotNav'),
      title: 'Urgensi',
    ),
    TabItem(
      icon: IconData(0xe902, fontFamily: 'CustomIconsBotNav'),
      title: 'Cara Melapor',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            selectedPage = index;
          });
        },
      ),
      bottomNavigationBar: [0, 2, 3].contains(selectedPage) ? 
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(202, 213, 226, 1),
              width: 1,
            ),
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.045),
          child: BottomBarDefault(
            animated: true,
            titleStyle: TextStyle(
              fontFamily: 'Instrument-Sans',
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
            colorSelected: Color.fromRGBO(17, 84, 237, 1),
            color: Color.fromRGBO(75, 87, 103, 1),
            backgroundColor: Colors.white,
            items: items,
            indexSelected: selectedPage,
            onTap: (int index) {
              _pageController.jumpToPage(index);
              setState(() {
                selectedPage = index;
              });
            },
          ),
        ),
      )
      : null,
    );
  }
}
