import 'package:flutter/material.dart';
import 'package:balapin/models/model_rekomendasi.dart';
import 'package:balapin/services/apiservicerekomendasi.dart';
import 'package:balapin/widgets/area_urgensi/card_urgensi.dart';
import 'package:balapin/widgets/navigations/botnav.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:balapin/widgets/area_urgensi/filter_chip.dart';

class RekomendasiUrgensiPages extends StatefulWidget {
  const RekomendasiUrgensiPages({super.key});

  @override
  State<RekomendasiUrgensiPages> createState() =>
      _RekomendasiUrgensiPagesState();
}

class _RekomendasiUrgensiPagesState extends State<RekomendasiUrgensiPages>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String _order = 'desc';

  Future<void> _handleRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: PhosphorIcon(
            PhosphorIconsLight.arrowLeft,
            color: Colors.black,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
            );
          },
        ),
        title: const Text(
          'Area Urgensi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.045,
        ),
        child: Column(
          children: [
            FilterUrgensi(
              onChanged: (order) {
                setState(() {
                  _order = order;
                });
              },
            ),

            // List scrollable card
            Expanded(
              child: FutureBuilder<List<ModelCardRekomendasi>>(
                future: getCardRekomendasi(_order),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var listData = snapshot.data;

                    if (listData!.length == 0) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(PhosphorIconsBold.chartBar),
                          Text(
                            'Belum ada rekomendasi saat ini',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    } else {
                      return RefreshIndicator(
                        color: Color.fromRGBO(17, 84, 237, 1),
                        onRefresh: _handleRefresh,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: CardUrgensi(
                                indexrekomen: listData[index],
                              ), // komponen kartu kamu
                            );
                          },
                        ),
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Lottie.asset(
                            'assets/icons/dialog/loadinganimation.json',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState != ConnectionState.none) {
                    return Text('Layanan sedang nonaktif mohon maaf');
                  } else {
                    return Text('Kesalahan layanan');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
