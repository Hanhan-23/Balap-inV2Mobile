// DALAM PENGEMBANGAN (BELUM DIIMPLEMENTASIKAN)

import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


void choachMarkBuatLapor(BuildContext context, List<GlobalKey> targetKeys, List<String> pesan, VoidCallback onclick) {
   
   
   List<TargetFocus> targets = [
    targetFocusOn(targetKeys[0], pesan[0]),
    targetFocusOn(targetKeys[1], pesan[1]),
    targetFocusOn(targetKeys[2], pesan[2]),
    targetFocusOn(targetKeys[3], pesan[3]),
    targetFocusOn(targetKeys[4], pesan[4]),
    targetFocusOn(targetKeys[5], pesan[5]),
    targetFocusOn(targetKeys[6], pesan[6]),
    targetFocusOn(targetKeys[7], pesan[7]),
    targetFocusOn(targetKeys[8], pesan[8]),
  ];
 
  TutorialCoachMark(
      hideSkip: true,
      textSkip: '',
      onClickTarget: (target) {
        onclick();
      },
      targets: targets,
      colorShadow: Color.fromRGBO(202, 213, 226, 100),
      paddingFocus: 5,
      opacityShadow: 0.8,
    ).show(context: context);
}

dynamic targetFocusOn(GlobalKey targetKeysOn, String pesanOn) {
    return TargetFocus(
      identify: "$targetKeysOn",
      keyTarget: targetKeysOn,
      contents: [
        TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(17, 84, 237, 1),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      pesanOn,
                      style: TextStyle(
                        fontFamily: 'Instrument-Sans',
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
   }