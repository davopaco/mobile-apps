import 'package:get/get.dart';
import 'package:quiz3/login/login_service.dart';

class LoginUseCase {
  final LoginService _loginService = LoginService();

  Future<void> login(String username, String password) async {
    final result = await _loginService.login(username, password);
    if (result) {
      if (await hasBiometrics()) {
        Get.offAllNamed('/menu');
      } else {
        Get.offAllNamed('/biometrics');
      }
      return;
    }
    Get.snackbar("Error", "Invalid credentials");
  }

  Future<void> logout() async {
    await _loginService.logout();
  }

  Future<bool> removeSession() async {
    final result = await _loginService.authenticate();
    if (result) {
      return await _loginService.removeSessionToken();
    }
    return false;
  }

  Future<bool> hasBiometrics() async {
    final tokenMap = await _loginService.getSessionToken();
    return !tokenMap['error'];
  }

  Future<void> authenticate() async {
    try {
      if (await hasBiometrics()) {
        final result = await _loginService.authenticate();
        if (result) {
          final loginResult = await _loginService.loginWithBiometrics();
          if (loginResult) {
            Get.offAllNamed('/menu');
          } else {
            Get.snackbar("Error", "Login failed");
          }
        }
      } else {
        Get.snackbar("Error", "No biometrics available");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> requestSessionToken(String username, String password) async {
    return await _loginService.requestSessionToken(username, password);
  }
}
