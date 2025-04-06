import 'package:flutter/material.dart';

class GapX extends StatelessWidget {
  final double size;
  const GapX(this.size, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(width: size);
}