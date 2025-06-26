import 'package:flutter/material.dart';
import 'package:balapin/models/model_notifikasi.dart';
import 'package:balapin/services/apiservicenotifikasi.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:balapin/widgets/Notifikasi/card_notifikasi.dart';

class NotifikasiPages extends StatefulWidget {
  const NotifikasiPages({super.key});

  @override
  State<NotifikasiPages> createState() => _NotifikasiPagesState();
}

class _NotifikasiPagesState extends State<NotifikasiPages> {

  late Future<List<ModelNotifikasi>> _futurenotifikasi;

  @override
  void initState() {
    super.initState();
    _futurenotifikasi = getCardNotifikasi();
  }

  @override
  Widget build(BuildContext context) {
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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child:
              Padding(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.045),  
      child:
          // List scrollable card
        FutureBuilder(
          future: _futurenotifikasi, 
          builder: (context, snapshot) {
            var listData = snapshot.data;
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: listData!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 0, bottom: 14),
                    child: CardNotifikasi(data: listData[index]),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Sedang menyediakan layanan mohon menunggu');
            } else if (snapshot.connectionState != ConnectionState.none) {
              return Text('Layanan sedang nonaktif mohon maaf');
            } else {
              return Text('Kesalahan layanan');
            }
          }
        )
        ),
      )
    );
  }
}