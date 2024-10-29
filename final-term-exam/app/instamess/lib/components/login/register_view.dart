import 'dart:io';
import 'package:flutter/material.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";
import 'package:image_picker/image_picker.dart';
import 'package:instamess/components/login/login_button.dart';
import 'package:instamess/components/general_textf.dart';
import 'package:instamess/model/interfaces/user_register.dart';
import 'package:instamess/model/position.dart';
import 'package:instamess/usecases/login_usecase.dart';
import 'package:instamess/usecases/user_usecase.dart';
import 'package:image_cropper/image_cropper.dart';

class RegisterView extends StatefulWidget {
  final LoginUseCase loginUsecase;
  final UserUsecase userUsecase;

  final host = dotenv.env['HOST'] ?? 'http://192.168.0.1';
  final port = dotenv.env['PORT'] ?? '3000';

  RegisterView(
      {super.key, required this.loginUsecase, required this.userUsecase});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;
  int selectedPosition = 0;

  Future<File?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(
            ratioX: 1, ratioY: 1), // Set aspect ratio to 1:1 for a square
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );

      if (croppedFile != null) {
        return File(croppedFile.path); // Return the cropped image as a File
      }
    }
    return null;
  }

  Future<void> _selectImage() async {
    final image = await pickImage();
    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image(
                width: 300,
                image: NetworkImage(
                    '${widget.host}:${widget.port}/images/logo.png',
                    scale: 0.5),
              ),
              const SizedBox(height: 40),
              GeneralTextField(
                labelText: "Email",
                eController: _emailController,
              ),
              GeneralTextField(
                labelText: "Contraseña",
                eController: _passwordController,
                obscureText: true,
              ),
              GeneralTextField(
                labelText: "Nombre",
                eController: _nameController,
              ),
              GeneralTextField(
                labelText: "Teléfono",
                eController: _phoneController,
              ),
              FutureBuilder(
                  future: widget.userUsecase.getAllPositions(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Position>> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                            labelText: "Cargo",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                          ),
                          items: snapshot.data!
                              .map((position) => DropdownMenuItem(
                                    value: position.id,
                                    child: Text(
                                      position.name,
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedPosition = value as int;
                            });
                          },
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Foto de perfil",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 64, 64, 64)),
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: _selectImage,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: _imageFile == null
                          ? const Icon(Icons.add_a_photo_rounded)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Image.file(
                                    _imageFile!,
                                  ),
                                ),
                              )),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              LoginButton(
                label: "Registrarse",
                callback: () {
                  widget.loginUsecase.register(UserRegister(
                    email: _emailController.text,
                    password: _passwordController.text,
                    name: _nameController.text,
                    fcmToken: '',
                    phone: int.parse(_phoneController.text),
                    positionId: selectedPosition,
                    profileImage: _imageFile!,
                  ));
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "¿Tienes una cuenta ya?",
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  "Iniciar sesión",
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 64, 64, 64)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
