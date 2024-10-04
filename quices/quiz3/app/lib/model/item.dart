import 'package:intl/intl.dart';

class Item {
  String name;
  String description;
  String normalPrice;
  String discountedPrice;
  int discount;
  double rating;
  String imagePath;
  int reviewsQuantity;

  Item(
      {required this.name,
      required this.description,
      required this.normalPrice,
      required this.discountedPrice,
      required this.discount,
      required this.rating,
      required this.imagePath,
      required this.reviewsQuantity});

  factory Item.fromJson(Map<String, dynamic> json) {
    int normalPrice = int.parse(json['price']);
    String discountedPrice =
        "\$ ${NumberFormat.decimalPattern("de_DE").format(normalPrice * (100 - int.parse(json['discount'])) ~/ 100)}";

    return Item(
        name: json['name'],
        normalPrice:
            "\$${NumberFormat.decimalPattern("de_DE").format(normalPrice)}",
        discountedPrice: discountedPrice,
        discount: int.parse(json['discount']),
        rating: int.parse(json['rating']) / 10,
        imagePath: json['imagePath'],
        reviewsQuantity: int.parse(json['ratingsQuantity']),
        description: json['description']);
  }
}
