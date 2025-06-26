import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:balapin/widgets/kustom_widget/gap_x.dart';
import 'package:balapin/widgets/kustom_widget/gap_y.dart';

class CardList extends StatelessWidget{
  const CardList ({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0XFFDFEAFF),
                borderRadius: BorderRadius.circular(100),
              ),
              child: PhosphorIcon(
              PhosphorIconsLight.city,
              color: Color(0XFF1154ED),
              size: 32,
            ),
            ),
            GapX(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    'Siapa yang bisa melapor?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  // description
                  GapY(8),
                  RichText(
                    text: TextSpan(
                      text: 'Anda yang merupakan warga ',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF1D293D),
                      ),
                      children: [
                        TextSpan(
                          text: 'Kota Batam.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF1D293D),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
        GapY(12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(0XFFDFEAFF),
                borderRadius: BorderRadius.circular(100),
              ),
              child: PhosphorIcon(
              PhosphorIconsLight.bridge,
              color: Color(0XFF1154ED),
              size: 32,
            ),
            ),
            GapX(12),
            Expanded(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(
                    'Apa yang bisa dilaporkan?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  // description
                  GapY(8),
                  RichText(
                    text: TextSpan(
                      text: 'Melihat kerusakan infrastruktur seperti jalan, lampu penerangan, dan jembatan.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFF1D293D),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),

      ],
    );
  }
}