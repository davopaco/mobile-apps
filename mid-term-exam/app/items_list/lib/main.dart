import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:items_list/factory/app_factory.dart';
import 'package:items_list/items/items_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: "assets/.env"); // Load .env file
  } catch (e) {
    print('.env file not found');
  }

  runApp(MaterialApp(
    home: ItemsView(
      apiEndpoint: "http://localhost:3000/item/all",
    ),
    //home: await AppFactory.getItemsManagerApp(),
  ));
}
