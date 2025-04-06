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
          // Tombol Urutkan Berdasarkan
          TextButton.icon(
            style: TextButton.styleFrom(
              shape: StadiumBorder(
                side: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            onPressed: () {},
            icon: PhosphorIcon(
            PhosphorIconsLight.slidersHorizontal,
            color: Colors.black,
            size: 16.0,
          ),
            label: Text(
              'Urutkan berdasarkan',
              style: TextStyle(color: Colors.black),
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
              borderRadius: BorderRadius.circular(20),
              selectedStyle: C2ChipStyle.filled(
                color: Colors.black,
                foregroundStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
