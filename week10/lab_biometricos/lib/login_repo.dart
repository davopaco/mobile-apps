import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<void> storeCredentials(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("jwt", token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("jwt");
    return storedData;
  }

  Future<void> removeCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt");
  }
}
