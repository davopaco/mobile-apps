import 'package:flutter/material.dart';
import 'package:instamess/factory/app_factory.dart';
import 'package:instamess/services/login_service.dart';

class AppUsecase {
  final LoginService _loginService;

  AppUsecase({required LoginService loginService})
      : _loginService = loginService;

  Future<Widget> getInstamessView() async {
    final userLoggedIn = await _loginService.isLoggedIn();
    if (userLoggedIn) {
      return AppFactory.getUsersView();
    } else {
      return AppFactory.getLoginView();
    }
  }
}
