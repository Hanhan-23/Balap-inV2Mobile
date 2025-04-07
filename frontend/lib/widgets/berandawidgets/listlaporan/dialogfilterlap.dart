import 'package:flutter/material.dart';

class DialogFilterLaporan extends StatefulWidget {
  const DialogFilterLaporan({super.key});

  @override
  State<DialogFilterLaporan> createState() => _DialogFilterLaporanState();
}

class _DialogFilterLaporanState extends State<DialogFilterLaporan> {
  int selectedChipIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    widgetFilterChip(String textLabelChip , int index) {
      return FilterChip(
        selectedColor: const Color(0XFFDFEAFF),
        label: Text(textLabelChip,
        style: TextStyle(
          fontFamily: 'Instrument-Sans',
          fontWeight: FontWeight.w400,
          color: Colors.black
        ),),
        selected: selectedChipIndex == index, 
        onSelected: (bool value) {
          setState(() {
            selectedChipIndex = index;
          });
        }
      );
    }

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.045),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text('Filter Berdasarkan',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Instrument-Sans',
                    fontWeight: FontWeight.w600
                  ),),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Wrap(
                    spacing: 4,
                    children: [
                      widgetFilterChip('Seminggu Terakhir' ,0),
                      widgetFilterChip('Sebulan Terakhir' ,1),
                      widgetFilterChip('Setahun Terakhir' ,2),
                      widgetFilterChip('Semua Periode' ,3),
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}