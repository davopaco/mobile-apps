import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<void> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("jwt", token);
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("jwt");
    if (storedData == null) {
      return "";
    }
    return storedData;
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt");
  }
}
