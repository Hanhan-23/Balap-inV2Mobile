import 'package:flutter/material.dart';
import 'package:frontend/widgets/berandawidgets/appbarberanda.dart';
import 'package:frontend/widgets/berandawidgets/mapberanda.dart';

class BerandaPages extends StatefulWidget {
  const BerandaPages({super.key});

  @override
  State<BerandaPages> createState() => _BerandaPagesState();
}

class _BerandaPagesState extends State<BerandaPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          child: AppBarBeranda()
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.045),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.35,
                child: MapBeranda(),
              ),
            ],
          )
        ),
      )
    );
  }
}