import 'package:flutter/material.dart';

class ButtonDeLoadDraft extends StatelessWidget {
  final Icon iconRequired;
  final Color colorButton;
  final void onPress;
  const ButtonDeLoadDraft({super.key , required this.iconRequired, required this.colorButton, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(202, 213, 226, 100))
      ),
      color: colorButton,
      icon: iconRequired,
      onPressed: () {
        onPress;
      },
    );
  }
}