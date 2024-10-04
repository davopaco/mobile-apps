import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz3/items/lista_articulos.dart';
import 'package:quiz3/items/lista_ofertas.dart';
import 'package:quiz3/login/biometrics_view.dart';
import 'package:quiz3/login/login_view.dart';
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
      '/biometrics': (context) => const BiometricsView(
            text: "Habilitar inicio de sesión con huella.",
            isForEnable: true,
          ),
      "/biometricsDisabled": (context) => const BiometricsView(
            text: "Inicio de sesión con huella habilitado.",
            buttonText: "Deshabilitar",
            buttonColor: Color.fromARGB(255, 217, 118, 19),
            isForEnable: false,
          ),
      "/menu": (context) => MenuPrincipal(),
      "/items": (context) => ListaArticulos(),
      "/sales": (context) => ListaOfertas(),
    },
    home: LoginView(),
  ));
}
