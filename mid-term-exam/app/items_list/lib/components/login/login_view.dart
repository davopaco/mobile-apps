import 'package:flutter/material.dart';
import 'package:items_list/components/login/login_button.dart';
import 'package:items_list/components/login/login_textf.dart';
import 'package:items_list/usecases/login_usecase.dart';

class LoginView extends StatefulWidget {
  final LoginUsecase loginUsecase;

  const LoginView({super.key, required this.loginUsecase});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                widget.loginUsecase
                    .login(_usernameController.text, _passwordController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
