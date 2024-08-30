import 'package:flutter/material.dart';
import 'package:login/login_service.dart';
import 'package:login/mock_view.dart';

class LoginUseCase {
  final LoginService _loginService = LoginService();

  Future<void> sendView(
      String username, String password, BuildContext context) async {
    final result = await _loginService.login(username, password);
    if (result == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MockView(
                    text: "Login was succesful!",
                  )));
    } else if (result == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MockView(
                    text: "User is already logged in!",
                  )));
    } else {
      _loginService.logout(username);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const MockView(
                    text: "Login failed!",
                  )));
    }
  }
}
