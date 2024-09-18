import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice2/ficha_articulo.dart';
import 'package:practice2/model/Item.dart';
import 'package:practice2/valoracion.dart';

class ItemArticulo extends StatelessWidget {
  final Item item;

  const ItemArticulo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => FichaArticulo(item: item),
            transition: Transition.upToDown,
            duration: const Duration(milliseconds: 100));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ],
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image(
                      image: NetworkImage(item.imagePath),
                      height: 80,
                      width: 80,
                    )),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.name,
                        style: const TextStyle(fontSize: 14),
                        softWrap: true,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Text(
                            item.discountedPrice,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          if (item.discount != 0)
                            Text(
                              "${item.discount}% OFF",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Valoracion(rating: item.rating)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
