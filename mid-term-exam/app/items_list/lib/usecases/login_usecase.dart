import 'package:get/get.dart';
import 'package:items_list/services/login_service.dart';

class LoginUsecase {
  final LoginService _loginService;

  LoginUsecase({required LoginService loginService})
      : _loginService = loginService;

  Future<bool> login(String username, String password) async {
    final result = await _loginService.login(username, password);
    if (result) {
      Get.offAllNamed("/items");
      return true;
    }
    Get.snackbar("Logout failed", "There was a problem logging out");
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
