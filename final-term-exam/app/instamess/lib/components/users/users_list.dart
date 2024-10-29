import 'package:flutter/material.dart';
import 'package:instamess/components/users/user_pod.dart';
import 'package:instamess/model/user.dart';
import 'package:instamess/usecases/message_usecase.dart';

class UsersList extends StatefulWidget {
  final List<User> users;
  final MessageUsecase messageUsecase;

  const UsersList(
      {super.key, required this.users, required this.messageUsecase});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.users.length,
      itemBuilder: (BuildContext context, int index) {
        return UserPod(
            user: widget.users[index], messageUsecase: widget.messageUsecase);
      },
    );
  }
}
