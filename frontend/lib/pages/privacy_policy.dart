import 'package:flutter/material.dart';
import 'package:balapin/callback/callbackpenggunabaru.dart';
import 'package:balapin/widgets/navigations/botnav.dart';
import 'package:balapin/widgets/privacy_policy/checkbox_widget.dart';
import 'package:balapin/widgets/kustom_widget/gap_y.dart';

class PrivacyPolicyPages extends StatefulWidget {
  const PrivacyPolicyPages({super.key});

  @override
  State<PrivacyPolicyPages> createState() => _PrivacyPolicyPagesState();
}

class _PrivacyPolicyPagesState extends State<PrivacyPolicyPages> {
  bool isChecked = false;

  void handleCheckboxChanged(bool value) {
    setState(() {
      isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 64, left: 32, right: 32, bottom: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section 1
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                  GapY(16),
                  Text(
                    'BALAP-IN',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GapY(16),
                  Text(
                    'Hadir untuk menyediakan pelaporan infrastruktur kota Batam dengan mudah dan cepat.',
                    style: TextStyle(fontSize: 16, color: Color(0XFF62748E)),
                  ),
                ],
              ),

              // section 2
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CheckboxPrivacyPolicy(onChanged: handleCheckboxChanged),
                    ],
                  ),
                  GapY(16),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor:
                            isChecked
                                ? Color(0XFF1154ED)
                                : Color.fromARGB(255, 136, 163, 226),
                      ),
                      onPressed: () {
                        if (isChecked == true) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigation(),
                            ),
                          );
                          setujuPenggunaBaru();
                        } else {
                          null;
                        }
                      },
                      child: const Text(
                        'Lanjut',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],

                // button
              ),
            ],
          ),
        ),
      ),
    );
  }
}
