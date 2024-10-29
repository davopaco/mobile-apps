import 'package:get/get.dart';
import 'package:instamess/model/interfaces/user_register.dart';
import 'package:instamess/services/login_service.dart';

class LoginUsecase {
  final LoginService _loginService;

  LoginUsecase({required LoginService loginService})
      : _loginService = loginService;

  Future<bool> login(String username, String password) async {
    final result = await _loginService.login(username, password);
    final name = await _loginService.getName();
    if (result) {
      Get.snackbar("Login Succesful!", "Welcome, $name");
      Get.offAllNamed("/items");
      return true;
    }
    Get.snackbar("Logout failed", "There was a problem logging out");
    return false;
  }

  Future<bool> register(UserRegister userRegister) async {
    final result = await _loginService.register(userRegister);
    if (result) {
      Get.snackbar("Registration Succesful!", "Welcome, ${userRegister.name}");
      Get.offAllNamed("/items");
      return true;
    }
    Get.snackbar("Registration failed", "There was a problem registering");
    return false;
  }

  Future<void> logout() async {
    final result = await _loginService.logout();
    if (result) {
      Get.offAllNamed("/login");
      return;
    }
    Get.snackbar("Logout failed", "There was a problem logging out");
  }
}
