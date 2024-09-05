import 'package:flutter/material.dart';
import 'package:items_list/services/items_service.dart';
import 'package:items_list/components/items/items_view.dart';
import 'package:items_list/services/login_service.dart';
import 'package:items_list/components/login/login_view.dart';

class ItemsManagerUseCase {
  final LoginService _loginService;
  final ItemsService _itemsService;

  ItemsManagerUseCase(
      {required LoginService loginService, required ItemsService itemsService})
      : _loginService = loginService,
        _itemsService = itemsService;

  Future<void> login(
      String username, String password, BuildContext context) async {
    final result = await _loginService.login(username, password, context);
    if (result) {
      final items = await _itemsService.getItems();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItemsView(apiEndpoint: "", items: items),
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
    final items = await _itemsService.getItems();
    //final username = await _loginService.getName();

    if (userLoggedIn) {
      return ItemsView(apiEndpoint: "", items: items);
      // return ItemsListView(username: username);
    } else {
      return LoginView(loginUsecase: this);
    }
  }

  Future<void> logout() async {
    await _loginService.logout();
  }
}
