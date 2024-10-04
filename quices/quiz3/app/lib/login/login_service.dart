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
    final headers = {'Content-Type': 'application/json'};

    final host = dotenv.env['API_URL'] ?? 'http://192.168.0.1:3000';
    final bodyJson = {};

    Map<String, dynamic> tokenMap = await getSessionToken();
    if (tokenMap['error']) {
      bodyJson['username'] = username;
      bodyJson['password'] = password;
    } else {
      headers['Authorization'] = 'Bearer ${tokenMap['token']}';
    }

    final body = jsonEncode(bodyJson);

    try {
      final url = '$host/user/login';
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        await _loginRepository.storeShortToken(token);
        return true; //User has successfully logged in
      }

      return false; //Login failed
    } catch (e) {
      Get.snackbar("Error", "There was an error logging in");
      print(e);
      return false;
    }
  }

  Future<bool> loginWithBiometrics() async {
    final loginResult = await login("", "");
    if (loginResult) {
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _loginRepository.removeShortToken();
    await _loginRepository.removeLongToken();
  }

  Future<bool> isLoggedIn() async {
    final token = await _loginRepository.getLongToken();

    if (token != null) {
      bool hasExpired = JwtDecoder.isExpired(token);

      if (!hasExpired) {
        return true; //User is logged in
      } else {
        await _loginRepository.removeLongToken(); // Log the user out
      }
    }

    return false;
  }

  Future<String> getName() async {
    final token = await _loginRepository.getLongToken();
    if (token != null) {
      final decodedToken = JwtDecoder.decode(token);
      return decodedToken['user'];
    }
    return '';
  }

  Future<Map<String, dynamic>> getSessionToken() async {
    var token = await _loginRepository.getLongToken();
    if (token != null) {
      return {"token": token, "error": false};
    }
    return {"token": "", "error": true};
  }

  Future<Map<String, dynamic>> getLoginToken() async {
    var token = await _loginRepository.getShortToken();
    if (token != null) {
      return {"token": token, "error": false};
    }
    return {"token": "", "error": true};
  }

  Future<bool> requestSessionToken(String username, String password) async {
    final headers = {'Content-Type': 'application/json'};
    final host = dotenv.env['API_URL'] ?? 'http://localhost:3000';
    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    try {
      final url = '$host/user/session';
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        await _loginRepository.storeLongToken(token);
        return true;
      }

      return false;
    } catch (e) {
      Get.snackbar("Error", "There was an error requesting the token");
      print(e);
      return false;
    }
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
