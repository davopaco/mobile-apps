import 'package:flutter/material.dart';
import 'package:items_list/login_use_case.dart';

class ItemsManagerApp extends StatelessWidget {
  final LoginUseCase _loginUsecase;

  const ItemsManagerApp({super.key, required loginUseCase})
      : _loginUsecase = loginUseCase;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<Widget>(
        future: _loginUsecase.sendView(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Text('We have an error :(');
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }
}
