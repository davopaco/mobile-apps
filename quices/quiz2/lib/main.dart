import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz2/lista_articulos.dart';
import 'package:quiz2/lista_ofertas.dart';
import 'package:quiz2/menu_principal.dart';

void main() {
  runApp(GetMaterialApp(
    routes: {
      "/items": (context) => ListaArticulos(),
      "/sales": (context) => ListaOfertas(),
    },
    home: MenuPrincipal(),
  ));
}
