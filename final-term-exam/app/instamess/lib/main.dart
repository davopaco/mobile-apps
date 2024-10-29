import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instamess/factory/app_factory.dart';
import 'package:instamess/firebase/firebase_api.dart';
import 'package:instamess/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(GetMaterialApp(
    home: await AppFactory.getInstamessView(),
    routes: {
      '/login': (context) => AppFactory.getLoginView(),
      '/register': (context) => AppFactory.getRegisterView(),
      '/messages': (context) => AppFactory.getMessagesView(),
      '/users': (context) => AppFactory.getUsersView(),
    },
  ));
}
