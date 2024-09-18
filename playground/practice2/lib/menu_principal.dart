import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Container(
            height: 600,
            width: 400,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Menu Principal',
                    style: TextStyle(
                      fontSize: 30,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.toNamed('/items');
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 93, 150, 197)),
                        padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                        shape: WidgetStatePropertyAll(CircleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                                width: 2))),
                      ),
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 100,
                        color: Colors.white,
                      )),
                  const Text(
                    "Artículos",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 93, 150, 197),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.toNamed('/sale');
                      },
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                            Color.fromARGB(255, 216, 22, 19)),
                        padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                        shape: WidgetStatePropertyAll(CircleBorder(
                            side: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 0),
                                width: 2))),
                      ),
                      icon: const Icon(
                        Icons.discount,
                        size: 100,
                        color: Colors.white,
                      )),
                  const Text(
                    "Ofertas",
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 216, 22, 19),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )),
      )),
    );
  }
}
