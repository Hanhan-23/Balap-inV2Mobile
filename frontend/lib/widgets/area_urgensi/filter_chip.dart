import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FilterUrgensi extends StatefulWidget {
  const FilterUrgensi({super.key});

  @override
  State<FilterUrgensi> createState() => _FilterUrgensiState();
}

class _FilterUrgensiState extends State<FilterUrgensi> {
  int selected = 0;
  final List<String> urutanOpsi = ['Tertinggi', 'Terendah'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          // Tombol 'Urutkan Berdasarkan'
          TextButton.icon(
            style: TextButton.styleFrom(
              shape: StadiumBorder(
                side: BorderSide(color: Color(0XFFCAD5E2), width: 1),
              ),
              padding: EdgeInsets.only(top: 4, left: 8, bottom: 4, right: 8),
            ),
            onPressed: () {},
            icon: PhosphorIcon(
            PhosphorIconsLight.slidersHorizontal,
            color: Colors.black,
            size: 16.0,
          ),
            label: Text(
              'Urutkan berdasarkan',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ),
          // Chips
          ChipsChoice<int>.single(
            value: selected,
            onChanged: (val) => setState(() => selected = val),
            choiceItems: C2Choice.listFrom<int, String>(
              source: urutanOpsi,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
            direction: Axis.horizontal,
            choiceStyle: C2ChipStyle.outlined(
              color: Color(0XFFCAD5E2),
              borderRadius: BorderRadius.circular(20),
              borderWidth: 1,
              foregroundStyle: TextStyle(color: Colors.black),
              selectedStyle: C2ChipStyle.filled(
                color: Color(0XFF1154ED),
                foregroundStyle: TextStyle(color: Colors.white),
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}
