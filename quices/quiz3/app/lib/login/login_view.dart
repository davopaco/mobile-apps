import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz3/login/login_button.dart';
import 'package:quiz3/login/login_textf.dart';
import 'package:quiz3/login/login_usecase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
        backgroundColor: const Color.fromARGB(255, 64, 64, 64),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              width: 200,
              image: NetworkImage('${dotenv.env['API_URL']}/images/logo.png'),
            ),
            const SizedBox(height: 50),
            LoginTextField(
              labelText: "Usuario",
              eController: _emailController,
            ),
            LoginTextField(
              labelText: "Contraseña",
              eController: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 50),
            LoginButton(
              label: "Login",
              color: const Color.fromARGB(255, 64, 64, 64),
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
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                await _loginUsecase.authenticateForLogin();
                              },
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                    style: BorderStyle.solid),
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Iniciar con huella",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                  SizedBox(width: 10),
                                  Icon(Icons.fingerprint, color: Colors.black),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed('/biometricsDisabled');
                              },
                              style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                    style: BorderStyle.solid),
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Deshabilitar huella",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                  SizedBox(width: 10),
                                  Icon(Icons.fingerprint, color: Colors.red),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox(
                      height: 10,
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
