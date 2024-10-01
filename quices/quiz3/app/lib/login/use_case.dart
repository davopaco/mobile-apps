import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:quiz3/login/login_serv.dart';
import 'package:quiz3/login/views.dart';

class LoginUseCase {
  final LoginService _loginService = LoginService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> login(String username, String password) async {
    final result = await _loginService.login(username, password);
    if (result) {
      if (await hasBiometrics()) {
        Get.offAllNamed('/mock');
      } else {
        Get.offAllNamed('/biometrics',
            arguments: {"username": username, "password": password});
      }
      return;
    }
    Get.snackbar("Error", "Invalid credentials");
  }

  Future<Widget> sendView() async {
    return LoginView();
  }

  Future<void> logout() async {
    await _loginService.logout();
  }

  Future<bool> enableBiometrics(String username, String password) async {
    final result = await _loginService.checkBiometrics();
    if (result) {
      await _storage.write(key: 'username', value: username);
      await _storage.write(key: 'password', value: password);
      await _storage.write(key: 'biometrics', value: 'true');
      return true;
    } else {
      Get.snackbar("Error", "No biometrics available");
      return false;
    }
  }

  Future<bool> hasBiometrics() async {
    final biometrics = await _storage.read(key: 'biometrics');
    print("On hasBiometrics: $biometrics");
    return biometrics != null;
  }

  Future<void> authenticate() async {
    try {
      bool authenticated = await _loginService.authenticate();
      if (authenticated) {
        Get.offAllNamed('/mock');
      }
    } catch (e) {
      print(e);
    }
  }
}
