import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/berandawidgets/analisisberanda.dart';
import 'package:frontend/widgets/berandawidgets/appbarberanda.dart';
import 'package:frontend/widgets/berandawidgets/mapberanda.dart';
import 'package:frontend/widgets/berandawidgets/listlaporanberanda.dart';
import 'package:frontend/models/model_laporan.dart';
import 'package:frontend/services/apiservicelaporan.dart';

class BerandaPages extends StatefulWidget {
  const BerandaPages({super.key});

  @override
  State<BerandaPages> createState() => _BerandaPagesState();
}

class _BerandaPagesState extends State<BerandaPages> with AutomaticKeepAliveClientMixin {
  int berdasarkan = 0;

  @override
  bool get wantKeepAlive => true;
  
  late Future<List<ModelCardLaporan>> _laporanFuture;
  
  @override
  void initState() {
    super.initState();
    _laporanFuture = getCardLaporan(berdasarkan, null);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    headerWidget() {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            child: MapBeranda(),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.18,
                child: AnalisisBeranda(laporanFuture: _laporanFuture), 
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          child: AppBarBeranda()
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.045),
          child: Scrollbar(
            radius: Radius.circular(100),
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
                ListLaporanBeranda(laporanFuture: _laporanFuture, filterindex: (int filterBerdasarkan) {
                  setState(() {
                    berdasarkan = filterBerdasarkan;
                    _laporanFuture = getCardLaporan(berdasarkan, null);
                  });
                },), 
              ],
            ),
          )
        ),
      )
    );
  }
}