import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String label;
  final Function callback;
  final Color color;
  const LoginButton(
      {super.key,
      required this.label,
      required this.callback,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: ElevatedButton(
        onPressed: () async {
          await callback();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
