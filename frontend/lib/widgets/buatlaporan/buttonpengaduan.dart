import 'package:flutter/material.dart';

class ButtonPengaduan extends StatelessWidget {
  const ButtonPengaduan({super.key});
  
  @override
  Widget build(BuildContext context) {
    Color colorKirim = Color.fromRGBO(17, 84, 237, 1);
    Color colorDraft = Colors.white;
    Color borderColor = Color.fromRGBO(202, 213, 226, 1);
    String textKirim = 'Kirim';
    String textDraft = 'Draft';
    Color textColorDraft = Colors.black;
    Color textColorKirim = Colors.white;
    
    buttonKirimDraft(colorButton, Color borderColor, String buttonText, Color textcolortext) {
      return TextButton(
            style: TextButton.styleFrom(
              overlayColor: Colors.black,
              backgroundColor: colorButton,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(
                  color: borderColor
                )
              )
            ),
            onPressed: () {
              null;
            }, 
            child: Text(buttonText,
            style: TextStyle(
              fontFamily: 'Instrument-Sans',
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: textcolortext,
            ),)
          );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: buttonKirimDraft(colorKirim, colorKirim, textKirim, textColorKirim)
        ),

        SizedBox(
          width: double.infinity,
          height: 52,
          child: buttonKirimDraft(colorDraft, borderColor, textDraft, textColorDraft)
        ),
      ],
    );
  }
}