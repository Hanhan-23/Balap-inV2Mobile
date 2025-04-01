import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AmbilGambar extends StatelessWidget {
  const AmbilGambar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.42,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              
              SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                child: Image.asset('assets/images/logo.png',
                fit: BoxFit.cover,),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: FloatingActionButton(
                    onPressed: () {
                    null;
                  },
                  backgroundColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset('assets/icons/buatlaporan/pencil-simple.svg',
                      colorFilter: ColorFilter.mode(
                        Color.fromRGBO(17, 84, 237, 1),
                        BlendMode.srcIn
                      ),
                    ),
                  ),
                  ),
                ),
              ),

            ],
          )
        ),
    );
  }
}