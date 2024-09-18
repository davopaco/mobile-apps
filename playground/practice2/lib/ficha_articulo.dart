import 'package:flutter/material.dart';
import 'package:practice2/model/Item.dart';
import 'package:practice2/regresar_button.dart';
import 'package:practice2/valoracion.dart';

class FichaArticulo extends StatelessWidget {
  final Item item;

  const FichaArticulo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
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
                    borderRadius: BorderRadius.circular(13)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 4,
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: NetworkImage(item.imagePath),
                            width: 300,
                          )),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(fontSize: 16),
                            softWrap: true,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              Text(
                                item.discountedPrice,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (item.discount != 0)
                                Text(
                                  "${item.discount}% OFF",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                            ],
                          ),
                          if (item.discount != 0)
                            Text(
                              "Antes ${item.normalPrice}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.rating.toString(),
                                style: const TextStyle(
                                    fontSize: 50, fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Valoracion(rating: item.rating),
                                  Text(
                                    "${item.reviewsQuantity} calificaciones",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const RegresarButton(),
            ],
          ),
        ),
      ),
    );
  }
}
