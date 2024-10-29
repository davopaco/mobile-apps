class UserRegister {
  String email;
  String password;
  String name;
  String fcmToken;
  BigInt phone;
  int positionId;

  UserRegister(
      {required this.email,
      required this.password,
      required this.name,
      required this.fcmToken,
      required this.phone,
      required this.positionId});

  toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'fcmToken': fcmToken,
      'phone': phone,
      'positionId': positionId
    };
  }
}
