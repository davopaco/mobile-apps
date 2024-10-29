import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:instamess/model/interfaces/user_login.dart';
import 'package:instamess/model/interfaces/user_register.dart';
import 'package:instamess/repositories/firebase_repository.dart';
import 'package:instamess/repositories/login_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginService {
  final LoginRepository _loginRepository;
  final FirebaseRepository _firebaseRepository;

  LoginService(
      {required LoginRepository loginRepository,
      required FirebaseRepository firebaseRepository})
      : _loginRepository = loginRepository,
        _firebaseRepository = firebaseRepository;

  Future<bool> login(UserLogin userLogin) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    userLogin.fcmToken = await _firebaseRepository.getToken();

    final host = dotenv.env['HOST'] ?? 'http://192.168.0.1';
    final port = dotenv.env['PORT'] ?? '3000';

    final body = jsonEncode(userLogin.toJson());

    try {
      final url = '$host:$port/user/login';
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      print(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        return await _loginRepository
            .storeToken(token); //User has successfully logged in
      }

      return false; //Login failed
    } catch (e) {
      Get.snackbar("Login failed", "There was a problem logging in");
      print(e);
      return false;
    }
  }

  Future<bool> register(UserRegister userRegister) async {
    final headers = {
      'Content-Type': 'application/json',
    };

    final host = dotenv.env['HOST'] ?? 'http://192.168.0.1';
    final port = dotenv.env['PORT'] ?? '3000';

    final body = jsonEncode(userRegister.toJson());

    try {
      final url = '$host:$port/user/register';
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        return await _loginRepository
            .storeToken(token); //User has successfully registered
      }

      return false; //Registration failed
    } catch (e) {
      Get.snackbar("Registration failed", "There was a problem registering");
      print(e);
      return false;
    }
  }

  Future<bool> logout() async {
    return await _loginRepository.removeToken();
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
      return decodedToken['name'];
    }
    return '';
  }
}
