class User {
  String email;
  String name;
  int phone;
  String position;
  String profileImage;
  bool sameUser;

  User(
      {required this.email,
      required this.name,
      required this.phone,
      required this.position,
      required this.profileImage,
      required this.sameUser});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        name: json['name'],
        phone: json['phone'],
        position: json['position'],
        profileImage: json['pfp'],
        sameUser: json['sameUser']);
  }
}
