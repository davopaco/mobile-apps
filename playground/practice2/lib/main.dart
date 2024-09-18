import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:practice2/lista_articulos.dart';
import 'package:practice2/lista_ofertas.dart';
import 'package:practice2/menu_principal.dart';

void main() {
  runApp(GetMaterialApp(
    routes: {
      '/items': (context) => ListaArticulos(),
      '/sale': (context) => ListaOfertas(),
    },
    home: const MenuPrincipal(),
  ));
}
