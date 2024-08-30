import 'package:flutter/material.dart';
import 'package:login/mock_view.dart';

class LoginButton extends StatelessWidget {
  final String label;
  final Function callback;
  const LoginButton({super.key, required this.label, required this.callback});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const MockView(text: 'Login Successful');
        }));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
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
