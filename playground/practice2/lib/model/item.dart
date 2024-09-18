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
    int normalPrice = int.parse(json['precio']);
    String discountedPrice =
        "\$ ${NumberFormat.decimalPattern("de_DE").format(normalPrice * (100 - int.parse(json['descuento'])) ~/ 100)}";

    return Item(
        name: json['articulo'],
        normalPrice:
            "\$ ${NumberFormat.decimalPattern("de_DE").format(normalPrice)}",
        discountedPrice: discountedPrice,
        discount: int.parse(json['descuento']),
        rating: int.parse(json['valoracion']) / 10,
        imagePath: json['urlimagen'],
        reviewsQuantity: int.parse(json['calificaciones']),
        description: json['descripcion']);
  }
}
