import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegresarButton extends StatelessWidget {
  const RegresarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 16, 120, 13)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Regresar',
                style: TextStyle(color: Colors.white),
              ),
              Icon(
                Icons.arrow_back,
                color: Colors.white,
              )
            ],
          )),
    );
  }
}
