import 'package:flutter/material.dart';
import 'package:balapin/models/model_notifikasi.dart';
import 'package:balapin/widgets/parsetimeago.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:balapin/widgets/kustom_widget/gap_x.dart';
import 'package:balapin/widgets/kustom_widget/gap_y.dart';

class CardNotifikasi extends StatelessWidget {
  final ModelNotifikasi data;
  const CardNotifikasi ({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0XFFCAD5E2),
          width: 1.0,
        ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0X1F000000),
          spreadRadius: 0,
          blurRadius: 4,
          offset: Offset(0, 4),
        ),
      ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Color(0XFFCAD5E2),
                width: 1.0,
              ),
            ),
            child: PhosphorIcon(
            PhosphorIconsLight.warningCircle,
            color: Color(0XFFE7000B),
            size: 24,
          ),
          ),
          GapX(12),
          Expanded(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title
                Text(
                  '${data.jalan} menjadi sorotan!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                // description
                GapY(8),
                Text(
                  data.pesan,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                GapY(8),
                Row(
                  children: [
                    PhosphorIcon(
                      PhosphorIconsLight.clock,
                      color: Color(0XFF62748E),
                      size: 16.0,
                    ),
                    GapX(4),
                    Text(
                      parsetimeago(data.tglNotif),
                      style: TextStyle(
                        color: Color(0XFF62748E),
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}