import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';


void showChoachMarkBeranda(BuildContext context, List<GlobalKey> targetKeys) {
   List<TargetFocus> targets = [
    TargetFocus(
      identify: "keyCaraMelapor",
      keyTarget: targetKeys[0],
      contents: [
        TargetContent(
            align: ContentAlign.left,
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
                      "Ayo lihat bagaimana cara melapor disini",
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
    ),
  ];
 
  TutorialCoachMark(
      onClickTarget: (p0) {
        null;
      },
      targets: targets,
      colorShadow: Color.fromRGBO(202, 213, 226, 100),
      textSkip: "SKIP",
      paddingFocus: 5,
      opacityShadow: 0.8,
    ).show(context: context);
}