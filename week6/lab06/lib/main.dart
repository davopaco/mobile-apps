import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab06/view_1.dart';
import 'package:lab06/view_2_3.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: '/',
    routes: {
      '/view2': (context) => const View2(params: "hola"),
    },
    home: const View1(),
  ));
}
