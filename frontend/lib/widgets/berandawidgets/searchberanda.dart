import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Searchberanda extends StatefulWidget {
  final Function(String) searchinput;
  const Searchberanda({super.key, required this.searchinput});

  @override
  State<Searchberanda> createState() => _SearchberandaState();
}

class _SearchberandaState extends State<Searchberanda> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        widget.searchinput(value);
      },
      controller: searchController,
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[\n\r]'))],
      cursorColor: Color(0XFF1154ED),
      maxLength: 40,
      maxLines: 1, 
      style: TextStyle(
        fontFamily: 'Instrument-Sans',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(46, 55, 68, 1),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ), 
        counterText: '',
        hintText: 'Cari kerusakan jalan menurut lokasi atau deskripsi',
        hintStyle: TextStyle(
          fontFamily: 'Instrument-Sans',
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color.fromRGBO(98, 116, 142, 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color.fromRGBO(202, 213, 226, 1),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(142, 153, 167, 1),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color.fromRGBO(206, 128, 128, 1),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color.fromRGBO(204, 76, 76, 1),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
