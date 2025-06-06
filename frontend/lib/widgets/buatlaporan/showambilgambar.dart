import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<void> showModalAmbilGambar(BuildContext context, Function(XFile?) onImagePicked) async {
  final picker = ImagePicker();

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
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.camera);
              Navigator.pop(context);
              onImagePicked(image);
            },
            child: const Text('Kamera', style: TextStyle(
              color: Colors.black,
              fontFamily: 'Instrument-Sans',
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final image = await picker.pickImage(source: ImageSource.gallery);
              Navigator.pop(context); 
              onImagePicked(image);
            },
            child: const Text('Galeri', style: TextStyle(
              color: Colors.black,
              fontFamily: 'Instrument-Sans',
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),),
          ),
        ],
      );
    },
  );
}