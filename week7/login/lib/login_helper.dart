class LoginHelper {
  static Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    return username == 'admin' && password == 'admin';
  }
}
