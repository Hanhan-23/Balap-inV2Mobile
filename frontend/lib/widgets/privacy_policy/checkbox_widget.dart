import 'package:flutter/material.dart';

class CheckboxPrivacyPolicy extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  const CheckboxPrivacyPolicy({super.key, required this.onChanged});

  @override
  State<CheckboxPrivacyPolicy> createState () => _CheckboxPrivacyPolicyState();
}

class _CheckboxPrivacyPolicyState extends State<CheckboxPrivacyPolicy> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Color(0XFF1154ED),
      side: BorderSide(
        color: Color(0XFFCAD5E2),
        width: 1,
        style: BorderStyle.solid,
      ),
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      contentPadding: EdgeInsets.only(left: 4,),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
        widget.onChanged(value!); 
      },
      subtitle: const Text(
        'Lorem ipsum dolor sit amet consectetur. Eu blandit leo etiam aliquam posuere ullamcorper. Habitasse quis sollicitudin.',
        style: TextStyle(
            fontSize: 12,
            color: Color(0XFF62748E),
          ),
        )
    );
  }
}