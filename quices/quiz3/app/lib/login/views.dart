import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz3/login/login_button.dart';
import 'package:quiz3/login/login_textf.dart';
import 'package:quiz3/login/login_usecase.dart';

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
              color: Colors.blue,
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
                        color: Colors.blue,
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

class BiometricsView extends StatefulWidget {
  final String text;
  final String buttonText;
  final Color buttonColor;

  const BiometricsView(
      {super.key,
      required this.text,
      this.buttonText = "Habilitar",
      this.buttonColor = const Color.fromARGB(255, 11, 122, 37)});

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
        title: const Text('Biometrics'),
        content: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final result = await _loginUsecase.requestSessionToken(
                  _usernameController.text, _passwordController.text);
              if (result) {
                await _loginUsecase.authenticate();
              } else {
                Get.snackbar("Error", "There was an error enabling biometrics");
                Get.offAllNamed('/login');
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
                await openDialog();
              }),
        ],
      )),
    );
  }
}
