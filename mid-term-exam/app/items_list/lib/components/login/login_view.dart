import 'package:flutter/material.dart';
import 'package:items_list/components/login/login_button.dart';
import 'package:items_list/components/login/login_textf.dart';
import 'package:items_list/usecases/login_usecase.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

class LoginView extends StatefulWidget {
  final LoginUsecase loginUsecase;
  final host = dotenv.env['HOST'] ?? 'http://192.168.0.1';
  final port = dotenv.env['PORT'] ?? '3000';

  LoginView({super.key, required this.loginUsecase});

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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: 200,
              image: NetworkImage(
                  '${widget.host}:${widget.port}/images/logo.png',
                  scale: 0.5),
            ),
            const SizedBox(height: 70),
            LoginTextField(
              labelText: "Username",
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
