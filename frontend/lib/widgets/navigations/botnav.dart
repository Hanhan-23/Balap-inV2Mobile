import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/coach_mark/callbackcoachmark.dart';
import 'package:frontend/coach_mark/coachmark.dart';
import 'package:frontend/pages/beranda.dart';
import 'package:frontend/pages/buatlapor.dart';
import 'package:frontend/pages/cara_melapor/informasi_umum.dart';
import 'package:frontend/pages/rekomendasi_urgensi.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  GlobalKey keyCaraMelapor = GlobalKey();
  int selectedPage = 0;
  final PageController _controller = PageController();

  final List<Widget> pages = [
    const BerandaPages(),
    const BuatLaporanPages(),
    const RekomendasiUrgensiPages(),
    const InformasiUmumPages(),
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

    void onTap(int index) {
    if (selectedPage != index) {
      _controller.jumpToPage(index);
      setState(() {
        selectedPage = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final cekcoachmark = checkCoachmarkPengguna();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await cekcoachmark == true && mounted) {
        showChoachMark(
        context, [keyCaraMelapor], 
        'Ayo lihat bagaimana cara melapor disini', 
        () {
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => InformasiUmumPages())
          );
        }
      );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: onTap,
        children: pages,
      ),
      bottomNavigationBar: [0, 2, 3].contains(selectedPage) ? 
      Stack(
        children: [
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
              onTap: onTap
            ),
          ),
        ),

        Positioned(
            bottom: 8,
            left: MediaQuery.of(context).size.width * 0.045 + 
                (MediaQuery.of(context).size.width * 0.91 / 4 * 3), 
            child: IgnorePointer(
              child: Container(
                key: keyCaraMelapor, 
                width: MediaQuery.of(context).size.width * 0.91 / 4,
                height: 56,
                color: Colors.transparent, 
              ),
            ),
          ),

        ],
      )
      : null,
    );
  }
}
