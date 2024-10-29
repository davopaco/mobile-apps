class UserLogin {
  String email;
  String password;
  String fcmToken;

  UserLogin(
      {required this.email, required this.password, required this.fcmToken});

  toJson() {
    return {
      'email': email,
      'password': password,
      'fcmToken': fcmToken,
    };
  }
}
