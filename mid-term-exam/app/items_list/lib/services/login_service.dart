import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:items_list/repositories/login_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginService {
  final LoginRepository _loginRepository;

  LoginService({required LoginRepository loginRepository})
      : _loginRepository = loginRepository;

  Future<bool> login(
      String username, String password, BuildContext context) async {
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
        await _loginRepository.storeToken(token);
        return true; //User has successfully logged in
      }

      return false; //Login failed
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There was an error logging in!'),
        ),
      );
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    await _loginRepository.removeToken();
  }

  Future<bool> isLoggedIn() async {
    final token = await _loginRepository.getToken();

    if (token != "") {
      bool hasExpired = JwtDecoder.isExpired(token);

      if (!hasExpired) {
        return true; //User is logged in
      } else {
        await _loginRepository.removeToken(); // Log the user out
      }
    }

    return false;
  }

  Future<String> getName() async {
    final token = await _loginRepository.getToken();
    if (token != "") {
      final decodedToken = JwtDecoder.decode(token);
      return decodedToken['user'];
    }
    return '';
  }
}
