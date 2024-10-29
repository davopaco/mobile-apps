import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instamess/usecases/login_usecase.dart';

class SlidingMenu extends StatefulWidget {
  final LoginUseCase loginUsecase;

  const SlidingMenu({super.key, required this.loginUsecase});

  @override
  _SlidingMenuState createState() => _SlidingMenuState();
}

class _SlidingMenuState extends State<SlidingMenu> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 122, 122, 122),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Menu',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(width: 10),
                Icon(
                  size: 30,
                  Icons.menu,
                  color: Colors.black,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
                leading: const Icon(Icons.person,
                    color: Color.fromARGB(255, 64, 64, 64)),
                title: const Text('Usuarios',
                    style: TextStyle(color: Color.fromARGB(255, 64, 64, 64))),
                onTap: () {
                  Get.toNamed("/users");
                }),
            ListTile(
              leading: const Icon(Icons.message,
                  color: Color.fromARGB(255, 64, 64, 64)),
              title: const Text('Mensajes recibidos',
                  style: TextStyle(color: Color.fromARGB(255, 64, 64, 64))),
              onTap: () {
                Get.toNamed("/messages");
              },
            ),
            ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Cerrar sesión',
                    style: TextStyle(color: Color.fromARGB(255, 64, 64, 64))),
                onTap: () async {
                  await widget.loginUsecase.logout();
                }),
          ],
        ),
      ),
    );
  }
}
