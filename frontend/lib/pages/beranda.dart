import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:balapin/widgets/berandawidgets/analisisberanda.dart';
import 'package:balapin/widgets/berandawidgets/appbarberanda.dart';
import 'package:balapin/widgets/berandawidgets/mapberanda.dart';
import 'package:balapin/widgets/berandawidgets/listlaporanberanda.dart';
import 'package:balapin/models/model_laporan.dart';
import 'package:balapin/services/apiservicelaporan.dart';
import 'package:balapin/widgets/berandawidgets/searchberanda.dart';

class BerandaPages extends StatefulWidget {
  const BerandaPages({super.key});

  @override
  State<BerandaPages> createState() => _BerandaPagesState();
}

class _BerandaPagesState extends State<BerandaPages>
    with AutomaticKeepAliveClientMixin {
  int berdasarkan = 0;
  String? searchinput;
  bool searchberanda = false;

  @override
  bool get wantKeepAlive => true;

  late Future<List<ModelCardLaporan>> _laporanFuture;

  @override
  void initState() {
    super.initState();
    _laporanFuture = getCardLaporan(berdasarkan, searchinput);
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _laporanFuture = getCardLaporan(berdasarkan, searchinput);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    headerWidget() {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            child: MapBeranda(),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 24),
              child: Container(
                decoration: BoxDecoration(color: Colors.white),
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
          child: AppBarBeranda(
            searchberanda: (bool searchBeranda) {
              setState(() {
                searchberanda = searchBeranda;
              });
            },
            isSearchVisible: searchberanda,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.045,
              ),
              child: Scrollbar(
                radius: Radius.circular(100),
                child: RefreshIndicator(
                  color: Color.fromRGBO(17, 84, 237, 1),
                  onRefresh: _handleRefresh,
                  child: DraggableHome(
                    centerTitle: true,
                    appBarColor: Colors.white,
                    headerExpandedHeight: 0.6,
                    title: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(75, 87, 103, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    headerWidget: headerWidget(),
                    body: [
                      ListLaporanBeranda(
                        laporanFuture: _laporanFuture,
                        filterindex: (int filterBerdasarkan) {
                          setState(() {
                            berdasarkan = filterBerdasarkan;
                            searchinput = searchinput;
                            _laporanFuture = getCardLaporan(
                              berdasarkan,
                              searchinput,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            if (searchberanda == true)
              Positioned(
                top: -1.5 * MediaQuery.of(context).padding.top + kToolbarHeight,
                width: MediaQuery.of(context).size.width * 1,
                height: 45,
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Searchberanda(
                    searchinput: (String value) {
                      setState(() {
                        searchinput = value;
                        _laporanFuture = getCardLaporan(
                          berdasarkan,
                          searchinput,
                        );
                      });
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
