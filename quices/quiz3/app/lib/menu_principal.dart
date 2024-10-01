import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 600,
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(spreadRadius: 2, blurRadius: 7, offset: Offset(0, 5))
              ],
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Menú principal",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              IconButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 82, 157, 219))),
                onPressed: () {
                  Get.toNamed("/items");
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Artículos",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 82, 157, 219)),
              ),
              const SizedBox(
                height: 30,
              ),
              IconButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                    backgroundColor: WidgetStatePropertyAll(
                        Color.fromARGB(255, 194, 33, 33))),
                onPressed: () {
                  Get.toNamed("/sales");
                },
                icon: const Icon(
                  Icons.discount,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Ofertas",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 194, 33, 33)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
