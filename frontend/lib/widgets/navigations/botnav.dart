import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}
  var selectedPage = 0;

  const List<TabItem> items = [
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

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(202, 213, 226, 1),
              width: 1
            )
          )
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.045),
          child: BottomBarDefault(
            animated: true,
            titleStyle: TextStyle(
              fontFamily: 'Instrument-Sans',
              fontSize: 10,
              fontWeight: FontWeight.w400
            ),
            colorSelected: Color.fromRGBO(17, 84, 237, 1),
            color: Color.fromRGBO(75, 87, 103, 1),
            backgroundColor: Colors.white,
            items: items,
            indexSelected: selectedPage, 
            onTap: (int index) => setState(() {
              selectedPage = index;
            })
          ),
        ),
    );
  }
}