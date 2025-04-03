import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AlamatPengaduan extends StatelessWidget {
  const AlamatPengaduan({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Alamat',
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Instrument-Sans',
                fontWeight: FontWeight.w400,
                fontSize: 14
              ),
            ),


            GestureDetector(
              onTap: () {
                null;
              },
              child: Row(
                spacing: 5,
                children: [
                  SvgPicture.asset('assets/icons/buatlaporan/pencil-simple.svg', width: 16, height: 16, 
                  colorFilter: ColorFilter.mode(
                      Color.fromRGBO(2, 54, 156, 1),
                      BlendMode.srcIn
                  ),),
              
                  const Text('Edit Lokasi',
                  style: TextStyle(
                      color: Color.fromRGBO(2, 54, 156, 1),
                      fontFamily: 'Instrument-Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 14
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
        
        SizedBox(
          height: 68,
          child: TextField(
            readOnly: true,
            textAlignVertical: TextAlignVertical.top,
            expands: true,
            maxLength: 40,
            maxLines: null,
            style: TextStyle(
              fontFamily: 'Instrument-Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(46, 55, 68, 1)
            ),
            decoration: InputDecoration(
              counterText: '',
              hintText: 'Jl. Ahmad Yani, Kabil, Kecamatan Nongsa, Kota Batam, Kepulauan Riau 29444',
              hintStyle: TextStyle(
                fontFamily: 'Instrument-Sans',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color.fromRGBO(98, 116, 142, 1)
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(202, 213, 226, 1)
                ),
                borderRadius: BorderRadius.circular(12)
              ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromRGBO(142, 153, 167, 1)
                ),
                borderRadius: BorderRadius.circular(12)
              ),

              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(206, 128, 128, 1)
                ),
                borderRadius: BorderRadius.circular(12)
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color.fromRGBO(204, 76, 76, 1)
                ),
                borderRadius: BorderRadius.circular(12)
              )
              
            ),
          ),
        )
      ],
    );
  }
}