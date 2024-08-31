import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:login/login_repo.dart';

class LoginService {
  final LoginRepository _loginRepository = LoginRepository();

  Future<bool> login(
      String username, String password, BuildContext context) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    try {
      const url = 'http://192.168.1.6:3000/login';
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
      } else {
        return false; //Login failed
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There was an error logging in!'),
        ),
      );
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
}
