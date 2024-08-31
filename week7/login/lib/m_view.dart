import 'package:flutter/material.dart';
import 'package:login/login_button.dart';
import 'package:login/login_use_case.dart';
import 'package:login/login_view.dart';

class MockView extends StatelessWidget {
  final String text;
  final LoginUseCase _loginUsecase = LoginUseCase();

  MockView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          LoginButton(
              label: "Logout",
              callback: () {
                _loginUsecase.logout();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ),
                  );
                }
              })
        ],
      )),
    );
  }
}
