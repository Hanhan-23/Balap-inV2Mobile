import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color colortext;
  final double fontsize;
  final FontWeight fontweight;

  const TextWidget({super.key, 
    required this.text, 
    required this.colortext, 
    required this.fontsize, 
    required this.fontweight
  });

  @override
  Widget build(BuildContext context) {
      
      return Text(
        text,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: colortext,
          fontFamily: 'Instrument-Sans',
          fontSize: fontsize,
          fontWeight: fontweight,
        ),
      );
    
  }
}