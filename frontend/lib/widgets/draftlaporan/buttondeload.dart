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
        side: WidgetStatePropertyAll(
          BorderSide(
            color: Color.fromRGBO(219, 220, 221, 1)        )
        ),
        backgroundColor: WidgetStatePropertyAll(Colors.white)
      ),
      color: colorButton,
      icon: iconRequired,
      onPressed: () {
        onPress;
      },
    );
  }
}