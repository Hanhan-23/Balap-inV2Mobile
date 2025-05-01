// DALAM PENGEMBANGAN (BELUM DIIMPLEMENTASIKAN)

import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


void choachMarkBuatLapor(BuildContext context, List<GlobalKey> targetKeys, List<String> pesan, VoidCallback onclick, ScrollController scrollController) {
   
  double scrollValue = 30.0;

  Future<void> addScrollValue(double maxScroll) async {
    if (scrollValue + 80.0 <= maxScroll) {
      scrollValue += 80.0;
    } else {
      scrollValue = maxScroll;
    }
  }

   List<TargetFocus> targets = [
    targetFocusOn(targetKeys[0], pesan[0], ContentAlign.bottom),
    targetFocusOn(targetKeys[1], pesan[1], ContentAlign.top),
    targetFocusOn(targetKeys[2], pesan[2], ContentAlign.top),
    targetFocusOn(targetKeys[3], pesan[3], ContentAlign.top),
    targetFocusOn(targetKeys[4], pesan[4], ContentAlign.top),
    targetFocusOn(targetKeys[5], pesan[5], ContentAlign.top),
    targetFocusOn(targetKeys[6], pesan[6], ContentAlign.top),
    targetFocusOn(targetKeys[7], pesan[7], ContentAlign.top),
    targetFocusOn(targetKeys[8], pesan[8], ContentAlign.top),
    targetFocusOn(targetKeys[9], pesan[9], ContentAlign.bottom),
  ];
 
  TutorialCoachMark(
      hideSkip: true,
      textSkip: '',
      onClickTarget: (target) async {
        onclick();
        double maxScroll = scrollController.position.maxScrollExtent;
        if (scrollValue <= maxScroll) {
          scrollController.animateTo(scrollValue, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          await addScrollValue(maxScroll);
          if (scrollValue > maxScroll) {
            scrollValue = maxScroll; 
          }
        }
      },
      targets: targets,
      colorShadow: Color.fromRGBO(202, 213, 226, 100),
      paddingFocus: 5,
      opacityShadow: 0.8,
    ).show(context: context);
}

dynamic targetFocusOn(GlobalKey targetKeysOn, String pesanOn, ContentAlign contentalign) {
    return TargetFocus(
      radius: 20,
      shape: ShapeLightFocus.RRect,
      identify: "$targetKeysOn",
      keyTarget: targetKeysOn,
      contents: [
        TargetContent(
            align: contentalign,
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