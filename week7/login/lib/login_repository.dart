import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  LoginRepository() {
    clearAll();
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> storeCredentials(String username, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(username, token);
  }

  Future<String?> getToken(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString(username);
    return storedData;
  }

  Future<void> removeCredentials(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(username);
  }
}
