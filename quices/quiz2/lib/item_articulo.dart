import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ficha_articulo.dart';
import 'model/item.dart';
import 'valoracion.dart';

class ItemArticulo extends StatelessWidget {
  final Item item;

  const ItemArticulo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FichaArticulo(item: item)); //For implementation
      },
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.imagePath,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            softWrap: true,
                          ),
                          Row(
                            children: [
                              Text(item.discountedPrice,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              const SizedBox(width: 10),
                              if (item.discount > 0)
                                Text("${item.discount.toString()}% OFF",
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 14)),
                            ],
                          ),
                          Valoracion(rating: item.rating),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
