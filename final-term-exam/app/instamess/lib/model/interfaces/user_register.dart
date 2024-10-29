import 'dart:io';

class UserRegister {
  String email;
  String password;
  String name;
  String fcmToken;
  int phone;
  int positionId;
  File profileImage;

  UserRegister(
      {required this.email,
      required this.password,
      required this.name,
      required this.fcmToken,
      required this.phone,
      required this.positionId,
      required this.profileImage});

  toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'fcmToken': fcmToken,
      'phone': phone,
      'positionId': positionId,
      'profileImage': profileImage
    };
  }
}
