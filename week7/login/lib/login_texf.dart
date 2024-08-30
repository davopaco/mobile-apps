import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController eController;
  final bool obscureText;

  const LoginTextField(
      {super.key,
      required this.labelText,
      required this.eController,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: TextField(
          obscureText: obscureText,
          controller: eController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            labelText: labelText,
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 120, 120, 120)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 27, 84, 131)),
              borderRadius: BorderRadius.circular(8),
            ),
            labelStyle: const TextStyle(
                color: const Color.fromARGB(255, 120, 120, 120)),
          ),
        ));
  }
}
