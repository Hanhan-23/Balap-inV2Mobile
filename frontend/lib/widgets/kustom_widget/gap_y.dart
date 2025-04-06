import 'package:flutter/material.dart';

class GapY extends StatelessWidget {
  final double size;
  const GapY(this.size, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}