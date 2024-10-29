import 'package:flutter/material.dart';
import 'package:instamess/components/users/users_list.dart';
import 'package:instamess/usecases/message_usecase.dart';
import 'package:instamess/usecases/user_usecase.dart';

class UsersView extends StatefulWidget {
  final UserUsecase userUsecase;
  final MessageUsecase messageUsecase;

  const UsersView(
      {super.key, required this.userUsecase, required this.messageUsecase});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60),
            const Text(
              'Usuarios',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder(
                  future: widget.userUsecase.getAllUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No users found');
                    } else {
                      final users = snapshot.data ?? [];
                      return UsersList(
                          users: users, messageUsecase: widget.messageUsecase);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
