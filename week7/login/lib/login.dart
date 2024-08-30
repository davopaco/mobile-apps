import 'package:flutter/material.dart';
import 'package:login/login_button.dart';
import 'package:login/login_texf.dart';
import 'package:login/mock_view.dart';

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
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                width: 200,
                image: NetworkImage(
                    'https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png'),
              ),
              const SizedBox(height: 50),
              const LoginTextField(labelText: "Email"),
              const LoginTextField(labelText: "Password"),
              const SizedBox(height: 50),
              LoginButton(
                label: "Login",
                callback: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const MockView(text: 'Login Successful');
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
