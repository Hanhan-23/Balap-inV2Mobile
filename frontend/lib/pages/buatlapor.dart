import 'package:flutter/material.dart';
import 'package:frontend/callback/callbackbuatlaporan.dart';
import 'package:frontend/coach_mark/coachmarkbuatlapor.dart';
import 'package:frontend/widgets/buatlaporan/alamatpengaduan.dart';
import 'package:frontend/widgets/buatlaporan/ambilgambar.dart';
import 'package:frontend/widgets/buatlaporan/appbarbuatlapor.dart';
import 'package:frontend/widgets/buatlaporan/buttonpengaduan.dart';
import 'package:frontend/widgets/buatlaporan/cuacapengaduan.dart';
import 'package:frontend/widgets/buatlaporan/deskripsipengaduan.dart';
import 'package:frontend/widgets/buatlaporan/judulpengaduan.dart';
import 'package:frontend/widgets/buatlaporan/nilaikerusakan.dart';

class BuatLaporanPages extends StatefulWidget {
  const BuatLaporanPages({super.key});

  @override
  State<BuatLaporanPages> createState() => _BuatLaporanPagesState();
}

class _BuatLaporanPagesState extends State<BuatLaporanPages> with AutomaticKeepAliveClientMixin{
  final ScrollController _scrollController = ScrollController();
  
  GlobalKey keyInputGambar = GlobalKey();
  GlobalKey keyInputJudul = GlobalKey();
  GlobalKey keyInputDeskripsi = GlobalKey();
  GlobalKey keyInputCuaca = GlobalKey();
  GlobalKey keyInputNilaiKerusakan = GlobalKey();
  GlobalKey keyInputAlamat = GlobalKey();
  GlobalKey keyKirim = GlobalKey();
  GlobalKey keyDraft = GlobalKey();
  GlobalKey keyDialogDraft = GlobalKey();
  
  @override
  bool get wantKeepAlive => true; 

  @override
  void initState() {
    super.initState();
    final cekCoachMarkBuat = checkBuatLaporan();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (await cekCoachMarkBuat == true && mounted) {
        choachMarkBuatLapor(
          context,
          [
            keyInputGambar,
            keyInputJudul,
            keyInputDeskripsi,
            keyInputCuaca,
            keyInputNilaiKerusakan,
            keyInputAlamat,
            keyKirim,
            keyDraft,
            keyDialogDraft
          ],
          [
            'Foto kerusakan infrastruktur yang ingin anda laporkan disini',
            'Masukkan judul laporan anda dengan tidak melebihi 40 karakter',
            'Masukkan Deskripsi laporan seperti kronologi atau penjelasan tambahan lainnya',
            'Pilih cuaca yang sesuai pada saat anda melapor',
            'Berapa persentase kerusakan menurut anda dari 0% sampai 100%',
            'Anda dapat menambahkan atau mengedit lokasi infrastruktur yang dilaporkan disini',
            'Klik tombol kirim apabila anda sudah yakin atau mengisi laporan dengan benar',
            'Atau anda bisa membuat draf laporan anda terlebih dahulu',
            'Lalu anda bisa melanjutkannya disini',
          ],
          () {
            validBuatLaporan();
          },
          _scrollController
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarBuatLapor(keyDialogDraft: keyDialogDraft),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Scrollbar(
            radius: Radius.circular(100),
            child: ListView(
              controller: _scrollController, 
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                AmbilGambar(key: keyInputGambar,),
                SizedBox(height: 12,),
                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: Judulpengaduan(key: keyInputJudul,)
                ),   
            
                SizedBox(height: 14,),   
                SizedBox(
                  width: double.infinity,
                  height: 176,
                  child: DeskripsiPengaduan(key: keyInputDeskripsi,)
                ),
            
                SizedBox(height: 14,), 
                SizedBox(
                  width: double.infinity,
                  height: 78,
                  child: CuacaPengaduan(key: keyInputCuaca,)
                ),
            
                SizedBox(height: 14,),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: NilaiKerusakan(key: keyInputNilaiKerusakan,)
                ),
            
                SizedBox(height: 14,),
                SizedBox(
                  width: double.infinity,
                  height: 98,
                  child: AlamatPengaduan(key: keyInputAlamat,)
                ),
            
                SizedBox(height: 40,),
                SizedBox(
                  width: double.infinity,
                  height: 118,
                  child: ButtonPengaduan(keyKirim: keyKirim, keyDraft: keyDraft)
                ),
                SizedBox(height: 14,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}