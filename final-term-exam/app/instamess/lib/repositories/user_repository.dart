import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:instamess/model/user.dart';
import 'package:instamess/repositories/login_repository.dart';

class UserRepository {
  final LoginRepository _loginRepository;
  final hostEndpoint =
      '${dotenv.env['HOST'] ?? 'http://localhost'}:${dotenv.env['PORT'] ?? '3000'}/user';

  UserRepository({required LoginRepository loginRepository})
      : _loginRepository = loginRepository;

  Future<List<User>> getUsers() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _loginRepository.getToken()}',
    };

    String route = '$hostEndpoint/all';

    final response = await http.get(Uri.parse(route), headers: headers);
    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      List<dynamic> usersJson = jsonResponse['users'];
      List<User> users = [];
      for (var userJson in usersJson) {
        users.add(User.fromJson(userJson));
      }
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> getUser(String email) async {
    String route = '$hostEndpoint?emailToGet=$email';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _loginRepository.getToken()}',
    };

    final response = await http.get(Uri.parse(route), headers: headers);
    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      dynamic userJson = jsonResponse['user'];
      return User.fromJson(userJson);
    } else {
      throw Exception('Failed to load the user with email $email');
    }
  }
}
