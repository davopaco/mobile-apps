import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:local_auth/local_auth.dart';
import 'package:quiz3/login/login_repo.dart';

class LoginService {
  final LoginRepository _loginRepository = LoginRepository();

  Future<bool> login(String username, String password) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final host = dotenv.env['HOST'] ?? 'http://192.168.0.1';
    final port = dotenv.env['PORT'] ?? '3000';

    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    try {
      final url = '$host:$port/login';
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        await _loginRepository.storeCredentials(token);
        return true; //User has successfully logged in
      }

      return false; //Login failed
    } catch (e) {
      Get.snackbar("Error", "There was an error logging in");
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    await _loginRepository.removeCredentials();
  }

  Future<bool> isLoggedIn() async {
    final token = await _loginRepository.getToken();

    if (token != null) {
      bool hasExpired = JwtDecoder.isExpired(token);

      if (!hasExpired) {
        return true; //User is logged in
      } else {
        await _loginRepository.removeCredentials(); // Log the user out
      }
    }

    return false;
  }

  Future<String> getName() async {
    final token = await _loginRepository.getToken();
    if (token != null) {
      final decodedToken = JwtDecoder.decode(token);
      return decodedToken['user'];
    }
    return '';
  }

  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<bool> checkBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } catch (e) {
      print('Error checking biometrics: $e');
      return false;
    }
  }

  // List available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      print('Error getting biometrics: $e');
      return <BiometricType>[];
    }
  }

  // Authenticate using biometrics
  Future<bool> authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Por favor autentique para acceder',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      return authenticated;
    } catch (e) {
      print('Error during authentication: $e');
      return false;
    }
  }
}
