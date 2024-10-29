import 'package:flutter/material.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";
import 'package:instamess/components/login/login_button.dart';
import 'package:instamess/components/login/login_textf.dart';
import 'package:instamess/model/interfaces/user_login.dart';
import 'package:instamess/usecases/login_usecase.dart';

class LoginView extends StatefulWidget {
  final LoginUsecase loginUsecase;
  final host = dotenv.env['HOST'] ?? 'http://192.168.0.1';
  final port = dotenv.env['PORT'] ?? '3000';

  LoginView({super.key, required this.loginUsecase});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
              labelText: "Email",
              eController: _emailController,
            ),
            LoginTextField(
              labelText: "Contraseña",
              eController: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 50),
            LoginButton(
              label: "Login",
              callback: () {
                widget.loginUsecase.login(UserLogin(
                    email: _emailController.text,
                    password: _passwordController.text,
                    fcmToken: ""));
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "¿No tienes una cuenta?",
              style: TextStyle(fontSize: 16),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text(
                "Registrar",
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 64, 64, 64)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
