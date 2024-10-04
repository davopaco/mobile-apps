import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz3/login/login_button.dart';
import 'package:quiz3/login/login_usecase.dart';

class BiometricsView extends StatefulWidget {
  final String text;
  final String buttonText;
  final Color buttonColor;
  final bool isForEnable;

  const BiometricsView(
      {super.key,
      required this.text,
      this.buttonText = "Habilitar",
      this.buttonColor = const Color.fromARGB(255, 11, 122, 37),
      required this.isForEnable});

  @override
  _BiometricsViewState createState() => _BiometricsViewState();
}

class _BiometricsViewState extends State<BiometricsView> {
  final LoginUseCase _loginUsecase = LoginUseCase();
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<String?> openDialog() async {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            contentPadding: EdgeInsets.all(20),
            insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              'Confirmar inicio de sesión con huella',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        labelText: 'Usuario', hintText: 'Usuario'),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: 'Contraseña', hintText: 'Contraseña'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
                      onPressed: () async {
                        final result = await _loginUsecase.requestSessionToken(
                            _usernameController.text, _passwordController.text);
                        if (!result) {
                          Get.snackbar("Error",
                              "There was an error enabling biometrics");
                        }
                        Get.offAllNamed('/menu');
                      },
                      child: const Text(
                        'Confirmar',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          LoginButton(
              label: widget.buttonText,
              color: widget.buttonColor,
              callback: () async {
                if (widget.isForEnable) {
                  final result = await _loginUsecase.authenticateForEnable();
                  if (!result) {
                    Get.snackbar("Error", "Biometrics not available");
                    Get.offAllNamed('/menu');
                    return;
                  }
                  await openDialog();
                } else {
                  if (!await _loginUsecase.removeSession()) {
                    Get.snackbar(
                        "Error", "There was an error disabling biometrics");
                  }
                  Get.offAllNamed('/login');
                }
              }),
        ],
      )),
    );
  }
}
