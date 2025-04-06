import 'package:flutter/material.dart';
import 'package:frontend/widgets/privacy_policy/checkbox_widget.dart';

class Gap extends StatelessWidget {
  final double size;
  const Gap(this.size, {super.key});

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}

class PrivacyPolicyPagesPages extends StatelessWidget {
  const PrivacyPolicyPagesPages({super.key});

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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                    Gap(16),
                    Text(
                      'BALAP-IN',
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(16),
                    Text(
                      'Lorem ipsum dolor sit amet consectetur. Eu blandit leo etiam aliquam posuere ullamcorper. Habitasse quis sollicitudin enim proin.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0XFF62748E),
                      ),
                    )

              ],
            ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CheckboxPrivacyPolicy(),
                      ],
                    ),
                    Gap(16),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0XFF1154ED),
                        ),
                        onPressed: ()
                        {
                          
                        },
                        child: const Text('Lanjut'),
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
