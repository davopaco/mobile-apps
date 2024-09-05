import 'package:flutter/material.dart';
import 'package:items_list/login_use_case.dart';
import 'package:items_list/login_button.dart';
import 'package:items_list/login_textf.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginUseCase _loginUsecase;

  LoginView({super.key, required LoginUseCase loginUsecase})
      : _loginUsecase = loginUsecase;

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
              eController: _usernameController,
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
                _loginUsecase.login(_usernameController.text,
                    _passwordController.text, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
