import 'package:flutter/material.dart';
import 'package:balapin/provider/laporan_provider.dart';
import 'package:provider/provider.dart';

class CuacaPengaduan extends StatefulWidget {
  const CuacaPengaduan({super.key});

  @override
  State<CuacaPengaduan> createState() => _CuacaPengaduanState();
}

const List<String> listCuaca = <String>['Cerah', 'Hujan'];

class _CuacaPengaduanState extends State<CuacaPengaduan> {
  @override
  Widget build(BuildContext context) {
    final laporanprovider = context.watch<LaporanProvider>();
    final selectedCuaca = laporanprovider.cuaca;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cuaca',
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Instrument-Sans',
            fontWeight: FontWeight.w400,
            fontSize: 14
          ),
        ),
        
        SizedBox(
          height: 52,
          child: DropdownButtonFormField<String>(
              key: const Key('cuaca_dropdown'),
              borderRadius: BorderRadius.circular(20),
              icon: Icon(Icons.keyboard_arrow_down),
              dropdownColor: Colors.white,
              hint: const Text( 
              "Pilih cuaca",
              style: TextStyle(
                fontFamily: 'Instrument-Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(98, 116, 142, 1), 
              ),
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: Color.fromRGBO(202, 213, 226, 1),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Color.fromRGBO(142, 153, 167, 1),
                ),
                borderRadius: BorderRadius.circular(12),
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
            value: selectedCuaca,
            onChanged: (value) {
              if (value != null) {
                context.read<LaporanProvider>().setCuaca(value);
              }
            },
            items: listCuaca.map<DropdownMenuItem<String>>((String listCuaca) {
              return DropdownMenuItem<String>(
                value: listCuaca,
                child: Text(
                  listCuaca,
                  style: const TextStyle(
                    fontFamily: 'Instrument-Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(46, 55, 68, 1),
                  ),
                ),
              );
            }).toList(),
          )
        )
      ],
    );
  }
}