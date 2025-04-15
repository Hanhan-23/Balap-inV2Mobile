import 'package:flutter/material.dart';
import 'package:frontend/callback/callbackpenggunabaru.dart';
import 'package:frontend/widgets/navigations/botnav.dart';
import 'package:frontend/widgets/privacy_policy/checkbox_widget.dart';
import 'package:frontend/widgets/kustom_widget/gap_y.dart';

class PrivacyPolicyPages extends StatelessWidget {
  const PrivacyPolicyPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: 
          Padding(
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
                      'Lorem ipsum dolor sit amet consectetur. Eu blandit leo etiam aliquam posuere ullamcorper. Habitasse quis sollicitudin enim proin.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0XFF62748E),
                      ),
                    )

              ],
            ),

                // section 2
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CheckboxPrivacyPolicy(),
                      ],
                    ),
                    GapY(16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0XFF1154ED),
                        ),
                        onPressed: ()
                        {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => BottomNavigation(),), 
                          );
                          setujuPenggunaBaru();
                        },
                        child: const Text(
                          'Lanjut',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color:Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],

                  // button
                ),
              ],
            ),
          )
        ),
    );
  }
}
