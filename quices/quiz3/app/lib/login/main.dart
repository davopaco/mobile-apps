import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:quiz3/login/login_app.dart';
import 'package:quiz3/login/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: "assets/.env"); // Load .env file
  } catch (e) {
    print('.env file not found');
  }

  runApp(GetMaterialApp(
    home: LoginApp(),
    routes: {
      '/biometrics': (context) => BiometricsView(
            text: "Desea habilitar el login con datos biométricos?",
          ),
      '/login': (context) => LoginView(),
      '/mock': (context) => MockView(text: "Bienvenido"),
    },
  ));
}
