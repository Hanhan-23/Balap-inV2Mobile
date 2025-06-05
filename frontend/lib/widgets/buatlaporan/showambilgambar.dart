import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future showModalAmbilGambar(context) {
  return showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return CupertinoActionSheet(
        title: const Text(
          'Ambil gambar melalui',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Instrument-Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {},
            child: Text(
              'Kamera',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Instrument-Sans',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          CupertinoActionSheetAction(
            onPressed: () {},
            child: Text(
              'Galeri',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Instrument-Sans',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    },
  );
}
