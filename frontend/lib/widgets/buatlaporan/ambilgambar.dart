import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/provider/laporan_provider.dart';
import 'package:frontend/widgets/buatlaporan/showambilgambar.dart';
import 'package:provider/provider.dart';

class AmbilGambar extends StatelessWidget {
  const AmbilGambar({super.key});

  @override
  Widget build(BuildContext context) {
    final laporanprovider = Provider.of<LaporanProvider>(context, listen: false);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.42,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Consumer<LaporanProvider>(
              builder: (context, provider, child) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: provider.gambar != null
                      ? Image.file(
                          File(provider.gambar!),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                        ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: 48,
                height: 48,
                child: FloatingActionButton(
                  onPressed: () {
                    showModalAmbilGambar(context, (image) {
                      if (image != null) {
                        laporanprovider.setGambar(image.path);
                      }
                    });
                  },
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      'assets/icons/buatlaporan/pencil-simple.svg',
                      colorFilter: const ColorFilter.mode(
                        Color.fromRGBO(17, 84, 237, 1),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
