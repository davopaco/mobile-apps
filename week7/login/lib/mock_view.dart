import 'package:flutter/material.dart';
import 'package:login/login_button.dart';

class MockView extends StatelessWidget {
  final String text;
  const MockView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          LoginButton(
              label: "Go back!",
              callback: () {
                Navigator.pop(context);
              })
        ],
      )),
    );
  }
}
