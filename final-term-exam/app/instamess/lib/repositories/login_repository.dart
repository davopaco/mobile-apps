import 'package:shared_preferences/shared_preferences.dart';

class LoginRepository {
  Future<bool> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString("jwt", token);
    if (result) {
      return true;
    }
    return false;
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("jwt");
    if (storedData == null) {
      return "";
    }
    return storedData;
  }

  Future<bool> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove("jwt");
    if (result) {
      return true;
    }
    return false;
  }
}
