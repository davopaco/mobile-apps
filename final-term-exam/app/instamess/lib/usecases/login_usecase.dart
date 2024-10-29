import 'package:get/get.dart';
import 'package:instamess/model/interfaces/user_login.dart';
import 'package:instamess/model/interfaces/user_register.dart';
import 'package:instamess/services/login_service.dart';

class LoginUseCase {
  final LoginService _loginService;

  LoginUseCase({required LoginService loginService})
      : _loginService = loginService;

  Future<bool> login(UserLogin userLogin) async {
    final result = await _loginService.login(userLogin);
    final name = await _loginService.getName();
    if (result) {
      Get.snackbar("Inicio de sesión exitoso!", "Binevenida/o, $name");
      Get.offAllNamed("/users");
      return true;
    }
    Get.snackbar(
        "Inicio de sesión fallido", "Ocurrió un problema al iniciar sesión");
    return false;
  }

  Future<bool> register(UserRegister userRegister) async {
    final result = await _loginService.register(userRegister);
    if (result) {
      Get.snackbar("Registro exitoso!", "Binevenida/o, ${userRegister.name}");
      Get.offAllNamed("/users");
      return true;
    }
    Get.snackbar("Registro fallido", "Ocurrió un problema al registrarse");
    return false;
  }

  Future<void> logout() async {
    final result = await _loginService.logout();
    if (result) {
      Get.offAllNamed("/login");
      return;
    }
    Get.snackbar("Salida de sesión fallida", "Ocurrió un problema al salir");
  }
}
