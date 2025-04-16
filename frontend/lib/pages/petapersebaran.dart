import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PetaPersebaran extends StatelessWidget {
  const PetaPersebaran({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/icons/buatlaporan/arrowleft.svg',
            width: 32,
            height: 32,
          ),
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Peta Persebaran',
                style: TextStyle(
                  fontFamily: 'instrument-Sans',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),

      body: Placeholder(
        color: Colors.yellow,
      ),
    );
  }
}
