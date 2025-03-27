import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MapBeranda extends StatefulWidget {
  const MapBeranda({super.key});

  @override
  State<MapBeranda> createState() => _MapBerandaState();
}

  viewMap() {
    return Container(
      color: Colors.yellow,
    );
  }

  mapButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.white)
        ),
        onPressed: () {
          null;
        }, icon: SvgPicture.asset('assets/icons/beranda/fullmap.svg')
      ),
    );
  }

class _MapBerandaState extends State<MapBeranda> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          viewMap(),
          mapButton(),
        ],
      ),
    );
  }
}