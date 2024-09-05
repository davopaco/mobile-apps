class Item {
  final int id;
  final String name;
  final String vendor;
  final double rating;
  final String imagePath;

  Item(
      {required this.id,
      required this.name,
      required this.vendor,
      required this.rating,
      required this.imagePath});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'],
        name: json['name'],
        vendor: json['vendor'],
        rating: json['rating'],
        imagePath: json['imagePath']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'vendor': vendor,
      'rating': rating,
      'imagePath': imagePath
    };
  }
}
