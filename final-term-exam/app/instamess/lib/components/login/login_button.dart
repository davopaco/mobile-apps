import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String label;
  final Function callback;
  const LoginButton({super.key, required this.label, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        callback();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 64, 64, 64),
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label,
          style: const TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}
