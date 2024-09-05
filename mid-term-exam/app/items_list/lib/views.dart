import 'package:flutter/material.dart';
import 'package:login/login_button.dart';
import 'package:login/login_use_case.dart';
import 'package:login/login_textf.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginUseCase _loginUsecase = LoginUseCase();

  LoginView({super.key});

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
                _loginUsecase.login(
                    _emailController.text, _passwordController.text, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MockView extends StatelessWidget {
  final String text;
  final LoginUseCase _loginUsecase = LoginUseCase();

  MockView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          LoginButton(
              label: "Logout",
              callback: () {
                _loginUsecase.logout();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );
                }
              })
        ],
      )),
    );
  }
}
