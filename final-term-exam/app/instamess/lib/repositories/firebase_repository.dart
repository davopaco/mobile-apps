import 'package:shared_preferences/shared_preferences.dart';

class FirebaseRepository {
  Future<bool> storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString("fcm", token);
    if (result) {
      return true;
    }
    return false;
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final storedData = prefs.getString("fcm");
    if (storedData == null) {
      return "";
    }
    return storedData;
  }
}
