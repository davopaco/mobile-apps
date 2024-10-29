import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:instamess/model/user.dart';

class UserRepository {
  final hostEndpoint =
      '${dotenv.env['HOST'] ?? 'http://localhost'}:${dotenv.env['PORT'] ?? '3000'}/user';

  Future<List<User>> getUsers() async {
    String route = '$hostEndpoint/all';

    final response = await http.get(Uri.parse(route));
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

    final response = await http.get(Uri.parse(route));
    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      dynamic userJson = jsonResponse['user'];
      return User.fromJson(userJson);
    } else {
      throw Exception('Failed to load the user with email $email');
    }
  }
}
