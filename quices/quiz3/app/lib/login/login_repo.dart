import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<void> storeCredentials(String token, String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("jwt_$type", token);
  }

  Future<String?> getToken(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("jwt_$type");
    return storedData;
  }

  Future<void> removeCredentials(String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt_$type");
  }
}
