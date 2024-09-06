import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:items_list/components/items/items_view.dart';
import 'package:items_list/factory/app_factory.dart';
import "package:get/get.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: "assets/.env"); // Load .env file
  } catch (e) {
    print('.env file not found');
  }

  runApp(GetMaterialApp(
    home: await AppFactory.getItemsManagerApp(),
    routes: {
      "/login": (context) => AppFactory.getLoginView(),
      "/items": (context) => FutureBuilder<ItemsView>(
            future: AppFactory.getItemsView(isFavoriteView: false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error loading items');
              } else {
                return snapshot.data!;
              }
            },
          ),
      "/favorites": (context) => FutureBuilder<ItemsView>(
            future: AppFactory.getItemsView(isFavoriteView: true),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error loading favorite items');
              } else {
                return snapshot.data!;
              }
            },
          ),
    },
  ));
}
