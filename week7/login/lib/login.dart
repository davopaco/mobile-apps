import 'package:flutter/material.dart';
import 'package:login/login_button.dart';
import 'package:login/login_texf.dart';
import 'package:login/login_usecase.dart';

class LoginApp extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginUseCase _loginUsecase = LoginUseCase();

  LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            LoginTextField(
              labelText: "Email",
              eController: _emailController,
            ),
            LoginTextField(
              labelText: "Password",
              eController: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 50),
            LoginButton(
              label: "Login",
              callback: () {
                _loginUsecase.sendView(
                    _emailController.text, _passwordController.text, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
