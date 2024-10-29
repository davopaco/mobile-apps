class Position {
  int id;
  String name;

  Position({required this.id, required this.name});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'],
      name: json['name'],
    );
  }
}
