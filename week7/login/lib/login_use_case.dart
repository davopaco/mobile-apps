import 'package:flutter/material.dart';
import 'package:login/login_serv.dart';
import 'package:login/views.dart';

class LoginUseCase {
  final LoginService _loginService = LoginService();

  Future<void> login(
      String username, String password, BuildContext context) async {
    final result = await _loginService.login(username, password, context);
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MockView(
            text: "Login Succesful! \nWelcome back, $username",
          ),
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login failed!'),
      ),
    );
  }

  Future<Widget> sendView() async {
    final userLoggedIn = await _loginService.isLoggedIn();
    final username = await _loginService.getName();

    if (userLoggedIn) {
      return MockView(
        text: "Welcome back! \n$username",
      );
    } else {
      return LoginView();
    }
  }

  Future<void> logout() async {
    await _loginService.logout();
  }
}
