import 'package:flutter/material.dart';

class Valoracion extends StatelessWidget {
  final double rating;

  const Valoracion({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool halfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.yellow);
        } else if (index == fullStars && halfStar) {
          return const Icon(Icons.star_half, color: Colors.yellow);
        } else {
          return const Icon(Icons.star, color: Colors.grey);
        }
      }),
    );
  }
}
