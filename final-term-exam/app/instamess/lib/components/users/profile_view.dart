import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instamess/components/general_button.dart';
import 'package:instamess/components/messages/message_modal.dart';
import 'package:instamess/model/user.dart';
import 'package:instamess/usecases/message_usecase.dart';

class ProfileView extends StatelessWidget {
  final User user;
  final MessageUsecase messageUsecase;
  late final Uint8List _imageBytes =
      base64Decode(user.profileImage.split(',')[1]);
  final TextStyle _dataStyle = const TextStyle(fontSize: 16);

  ProfileView({super.key, required this.user, required this.messageUsecase});

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
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
            !(user.sameUser)
                ? GeneralButton(
                    title: "Enviar mensaje",
                    icon: Icons.message,
                    color: Colors.green,
                    callback: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25.0),
                            ),
                          ),
                          builder: (BuildContext context) {
                            return MessageModal(
                              messageUsecase: messageUsecase,
                              recipientEmail: user.email,
                            );
                          });
                    })
                : const SizedBox(),
            GeneralButton(
                title: "Regresar",
                icon: Icons.arrow_back_ios,
                color: const Color.fromARGB(255, 64, 64, 64),
                callback: () {
                  Get.back();
                }),
          ],
        ),
      ),
    );
  }
}
