import 'package:flutter/material.dart';
import 'package:frontend/widgets/draftlaporan/listdraflapor.dart';

class DrafLaporScreen extends StatelessWidget {
  const DrafLaporScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.92,
        child: Column(
          spacing: 16,
          children: [
            Container(
              padding: EdgeInsets.only(top: 16),
              alignment: Alignment.topCenter,
              child: Container(
                alignment: AlignmentDirectional.centerStart,
                width: MediaQuery.of(context).size.width * 0.2,
                height: 5,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(202, 213, 226, 1),
                  borderRadius: BorderRadius.circular(200),
                ),
              ),
            ),

            Text(
              'Draf laporan anda',
              style: TextStyle(
                fontFamily: 'Instrument-Sans',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            Expanded(
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  ListDrafLapor(),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
