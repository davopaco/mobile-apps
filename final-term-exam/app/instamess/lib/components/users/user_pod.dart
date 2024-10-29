import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instamess/components/users/profile_view.dart';
import 'package:instamess/model/user.dart';
import 'package:instamess/usecases/message_usecase.dart';

class UserPod extends StatefulWidget {
  final User user;
  final MessageUsecase messageUsecase;

  const UserPod({super.key, required this.user, required this.messageUsecase});

  @override
  State<UserPod> createState() => _UserPodState();
}

class _UserPodState extends State<UserPod> {
  late Uint8List _imageBytes;
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
    _imageBytes = base64Decode(user.profileImage.split(',')[1]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProfileView(user: user));
      },
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(_imageBytes, width: 80, height: 80),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            softWrap: true,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            user.email,
                            softWrap: true,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
