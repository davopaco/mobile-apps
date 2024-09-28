import 'package:flutter/material.dart';

import 'model/item.dart';
import 'regresar_button.dart';
import 'valoracion.dart';

class FichaArticulo extends StatelessWidget {
  final Item item;

  const FichaArticulo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
              child: Container(
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
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.imagePath,
                        width: 200,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            softWrap: true,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(item.discountedPrice,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              const SizedBox(width: 10),
                              if (item.discount > 0)
                                Text("${item.discount.toString()}% OFF",
                                    style: const TextStyle(
                                        color: Colors.green, fontSize: 17)),
                            ],
                          ),
                          if (item.discount > 0)
                            Text(
                              "Antes ${item.normalPrice}",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.rating.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 40),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Column(
                                children: [
                                  Valoracion(rating: item.rating),
                                  Text(
                                    "${item.reviewsQuantity} calificaciones",
                                    style: const TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const RegresarButton()
          ],
        ),
      ),
    );
  }
}
