import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/berandawidgets/analisisberanda.dart';
import 'package:frontend/widgets/berandawidgets/appbarberanda.dart';
import 'package:frontend/widgets/berandawidgets/mapberanda.dart';
import 'package:frontend/widgets/navigations/botnav.dart';
import 'package:frontend/widgets/berandawidgets/listlaporanberanda.dart';

class BerandaPages extends StatefulWidget {
  const BerandaPages({super.key});

  @override
  State<BerandaPages> createState() => _BerandaPagesState();
}

class _BerandaPagesState extends State<BerandaPages> {
  @override
  Widget build(BuildContext context) {

    headerWidget () {
      return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                child: MapBeranda(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 24),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: AnalisisBeranda(),
                ),
              ),
            ],
          );
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      appBar: AppBar(
        title: SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          child: AppBarBeranda()
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.045),
          child: DraggableHome(
            centerTitle: true,
            appBarColor: Colors.white,
            headerExpandedHeight: 0.6,
            title: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 4,
              decoration: BoxDecoration(
                color: Color.fromRGBO(75, 87, 103, 1),
                borderRadius: BorderRadius.circular(20)
              ),
            ),
            headerWidget: headerWidget(), 
            body: [
              ListLaporanBeranda()
            ] 
          )
        ),
      )
    );
  }
}