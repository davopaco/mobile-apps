import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz3/items/lista_articulos.dart';
import 'package:quiz3/items/lista_ofertas.dart';
import 'package:quiz3/login/login_app.dart';
import 'menu_principal.dart';

void main() {
  runApp(GetMaterialApp(
    routes: {
      "/login": (context) => LoginApp(),
      "/menu": (context) => MenuPrincipal(),
      "/items": (context) => ListaArticulos(),
      "/sales": (context) => ListaOfertas(),
    },
    home: MenuPrincipal(),
  ));
}
