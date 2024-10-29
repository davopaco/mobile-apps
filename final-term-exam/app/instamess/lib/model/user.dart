class User {
  String email;
  String name;
  BigInt phone;
  String position;
  String profileImage;

  User(
      {required this.email,
      required this.name,
      required this.phone,
      required this.position,
      required this.profileImage});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        name: json['name'],
        phone: BigInt.parse(json['phone']),
        position: json['position'],
        profileImage: json['pfp']);
  }
}
