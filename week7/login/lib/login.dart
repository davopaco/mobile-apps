import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login/login_button.dart';
import 'package:login/login_texf.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login Page'),
          backgroundColor: Colors.blue,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        ),
        body: const Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: 200,
                image: NetworkImage(
                    'https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png'),
              ),
              SizedBox(height: 50),
              LoginTextField(labelText: "Email"),
              LoginTextField(labelText: "Password"),
              SizedBox(height: 50),
              LoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
