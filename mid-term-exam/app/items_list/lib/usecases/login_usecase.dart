import 'package:flutter/material.dart';
import 'package:items_list/factory/app_factory.dart';
import 'package:items_list/services/login_service.dart';

class LoginUsecase {
  final LoginService _loginService;

  LoginUsecase({required LoginService loginService})
      : _loginService = loginService;

  Future<bool> login(
      String username, String password, BuildContext context) async {
    final result = await _loginService.login(username, password, context);
    if (result) {
      final itemsView = await AppFactory.getItemsView();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => itemsView,
        ),
      );
      return true;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login failed!'),
      ),
    );
    return false;
  }

  Future<void> logout() async {
    await _loginService.logout();
  }
}
