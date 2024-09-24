import 'package:flutter/material.dart';
import 'package:items_list/factory/app_factory.dart';
import 'package:items_list/services/login_service.dart';

class ItemsManagerUseCase {
  final LoginService _loginService;

  ItemsManagerUseCase({required LoginService loginService})
      : _loginService = loginService;

  Future<Widget> sendView() async {
    final userLoggedIn = await _loginService.isLoggedIn();
    if (userLoggedIn) {
      return await AppFactory.getItemsView(isFavoriteView: false);
    } else {
      return AppFactory.getLoginView();
    }
  }
}
