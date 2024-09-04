import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:login/login/login_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: "assets/.env"); // Load .env file
  } catch (e) {
    print('.env file not found');
  }

  runApp(MaterialApp(
    home: LoginApp(),
  ));
}
