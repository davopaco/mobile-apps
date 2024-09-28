import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lista_articulos.dart';
import 'lista_ofertas.dart';
import 'menu_principal.dart';

void main() {
  runApp(GetMaterialApp(
    routes: {
      "/items": (context) => ListaArticulos(),
      "/sales": (context) => ListaOfertas(),
    },
    home: MenuPrincipal(),
  ));
}
