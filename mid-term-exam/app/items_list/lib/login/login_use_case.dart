import 'package:flutter/material.dart';
import 'package:items_list/login/login_service.dart';
import 'package:items_list/login/login_view.dart';

class LoginUseCase {
  final LoginService _loginService;

  LoginUseCase({required LoginService loginService})
      : _loginService = loginService;

  Future<void> login(
      String username, String password, BuildContext context) async {
    final result = await _loginService.login(username, password, context);
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Container(), //ItemsListView(username: username),
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
    //final username = await _loginService.getName();

    if (userLoggedIn) {
      return Container();
      // return ItemsListView(username: username);
    } else {
      return LoginView(loginUsecase: this);
    }
  }

  Future<void> logout() async {
    await _loginService.logout();
  }
}
