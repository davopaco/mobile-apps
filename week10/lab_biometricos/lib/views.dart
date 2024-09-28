import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_biometricos/login_button.dart';
import 'package:lab_biometricos/login_textf.dart';
import 'package:lab_biometricos/use_case.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginUseCase _loginUsecase = LoginUseCase();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              width: 200,
              image: NetworkImage(
                  'https://storage.googleapis.com/cms-storage-bucket/c823e53b3a1a7b0d36a9.png'),
            ),
            const SizedBox(height: 50),
            LoginTextField(
              labelText: "Email",
              eController: _emailController,
            ),
            LoginTextField(
              labelText: "Password",
              eController: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 50),
            LoginButton(
              label: "Login",
              callback: () {
                _loginUsecase.login(
                    _emailController.text, _passwordController.text);
              },
            ),
            const SizedBox(height: 20),
            FutureBuilder(
                future: _loginUsecase.hasBiometrics(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Text('We have an error :(');
                  } else {
                    print(snapshot.data);
                    if (snapshot.data == true) {
                      return LoginButton(
                        label: "Iniciar sesión con datos biométricos",
                        callback: () {
                          _loginUsecase.authenticate();
                        },
                      );
                    }
                    return SizedBox();
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class BiometricsView extends StatelessWidget {
  final String text;
  final LoginUseCase _loginUsecase = LoginUseCase();

  BiometricsView({super.key, required this.text});

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
              label: "Habilitar",
              callback: () {
                var args = Get.arguments;
                var username = args["username"];
                var password = args["password"];
                _loginUsecase.enableBiometrics(username, password);
                Get.offAllNamed('/login');
              }),
        ],
      )),
    );
  }
}

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
              label: "Volver",
              callback: () {
                Get.offAllNamed('/login');
              }),
        ],
      )),
    );
  }
}
