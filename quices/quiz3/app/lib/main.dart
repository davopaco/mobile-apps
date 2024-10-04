import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz3/items/lista_articulos.dart';
import 'package:quiz3/items/lista_ofertas.dart';
import 'package:quiz3/login/views.dart';
import 'items/menu_principal.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await GetStorage.init();

  try {
    await dotenv.load(fileName: "assets/.env"); // Load .env file
  } catch (e) {
    print('.env file not found');
  }

  runApp(GetMaterialApp(
    routes: {
      "/login": (context) => LoginView(),
      '/biometrics': (context) => BiometricsView(
            text: "Habilitar inicio de sesión con huella.",
          ),
      "/biometricsDisabled": (context) => BiometricsView(
            text: "Inicio de sesión con huella habilitado.",
            buttonText: "Deshabilitar",
            buttonColor: const Color.fromARGB(255, 217, 118, 19),
          ),
      "/menu": (context) => const MenuPrincipal(),
      "/items": (context) => ListaArticulos(),
      "/sales": (context) => ListaOfertas(),
    },
    home: LoginView(),
  ));
}
