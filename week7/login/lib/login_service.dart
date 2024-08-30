import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:login/login_repository.dart';

class LoginService {
  final LoginRepository _loginRepository = LoginRepository();

  Future<int> login(String username, String password) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    const url = 'http://192.168.1.7:3000/login';
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final bool loggedIn = await _isLoggedIn(username);

      if (loggedIn) {
        return 1; //User is already logged in
      }
      await _loginRepository.storeCredentials(username, token);
      return 0; //User has successfully logged in
    } else {
      return -1; //Login failed
    }
  }

  Future<bool> _isLoggedIn(String username) async {
    final token = await _loginRepository.getToken(username);

    if (token != null) {
      bool hasExpired = JwtDecoder.isExpired(token);

      if (!hasExpired) {
        return true; //User is logged in
      } else {
        await _loginRepository.removeCredentials(username); // Log the user out
      }
    }

    return false;
  }
}
