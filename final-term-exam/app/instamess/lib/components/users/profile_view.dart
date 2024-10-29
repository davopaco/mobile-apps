import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instamess/components/regresar_button.dart';
import 'package:instamess/model/user.dart';

class ProfileView extends StatelessWidget {
  final User user;
  late Uint8List _imageBytes = base64Decode(user.profileImage.split(',')[1]);
  final TextStyle _dataStyle = const TextStyle(fontSize: 16);

  ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60),
            Text(
              user.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ClipRect(
                child: Image.memory(
              _imageBytes,
              width: 200,
              height: 200,
            )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email),
                const SizedBox(width: 10),
                Text(user.email, style: _dataStyle),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone),
                const SizedBox(width: 10),
                Text(user.phone.toString(), style: _dataStyle),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.work),
                const SizedBox(width: 10),
                Text(user.position, style: _dataStyle),
              ],
            ),
            const SizedBox(height: 20),
            const RegresarButton(),
          ],
        ),
      ),
    );
  }
}
