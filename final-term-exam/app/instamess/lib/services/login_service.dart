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
  final host = dotenv.env['HOST'] ?? 'http://192.168.1.3';
  final port = dotenv.env['PORT'] ?? '3000';

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
    var request =
        http.MultipartRequest('POST', Uri.parse('$host:$port/user/register'));

    request.files.add(await http.MultipartFile.fromPath(
        'pfp', userRegister.profileImage.path));

    request.fields['email'] = userRegister.email;
    request.fields['password'] = userRegister.password;
    request.fields['name'] = userRegister.name;
    request.fields['fcmToken'] = await _firebaseRepository.getToken();
    request.fields['phone'] = userRegister.phone.toString();
    request.fields['positionId'] = userRegister.positionId.toString();

    try {
      final response = await request.send();

      print(response.statusCode);
      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final data = jsonDecode(responseBody);
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
    try {
      final jwtToken = await _loginRepository.getToken();
      final fcmToken = await _firebaseRepository.getToken();

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      };

      final body = jsonEncode({'fcmToken': fcmToken});

      final url = '$host:$port/user/logout';

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        await _loginRepository.removeToken();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
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
