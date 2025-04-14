import 'package:flutter/material.dart';

class BottomItemWrapper extends StatelessWidget {
  final Widget child;
  final GlobalKey keyWrapper;

  const BottomItemWrapper({super.key, required this.child, required this.keyWrapper});

  @override
  Widget build(BuildContext context) {
    return Container(key: keyWrapper, child: child,);
  }
}