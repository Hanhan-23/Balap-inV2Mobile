import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frontend/provider/laporan_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/widgets/buatlaporan/showambilgambar.dart';
import 'package:provider/provider.dart';

class AmbilGambar extends StatefulWidget {
  const AmbilGambar({super.key});

  @override
  State<AmbilGambar> createState() => _AmbilGambarState();
}

class _AmbilGambarState extends State<AmbilGambar> {
  XFile? pickedImage;

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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: pickedImage != null
                  ? Image.file(
                      File(pickedImage!.path),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.cover,
                    ),
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
                        setState(() {
                          pickedImage = image;
                        });

                        laporanprovider.setGambar(File(image.path));
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