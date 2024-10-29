import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instamess/components/item_circular_button.dart';
import 'package:instamess/components/sliding_menu.dart';
import 'package:instamess/components/users/users_list.dart';
import 'package:instamess/usecases/login_usecase.dart';
import 'package:instamess/usecases/message_usecase.dart';
import 'package:instamess/usecases/user_usecase.dart';

class UsersView extends StatefulWidget {
  final UserUsecase userUsecase;
  final LoginUseCase loginUsecase;
  final MessageUsecase messageUsecase;

  const UsersView(
      {super.key,
      required this.userUsecase,
      required this.messageUsecase,
      required this.loginUsecase});

  @override
  State<UsersView> createState() => _UsersViewState();
}

class _UsersViewState extends State<UsersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 60),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Usuarios',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: ItemCircularButton(
                          callback: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SlidingMenu(
                                    loginUsecase: widget.loginUsecase,
                                  );
                                });
                          },
                          icon: Icon(Icons.menu),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder(
                      future: widget.userUsecase.getAllUsers(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No users found');
                        } else {
                          final users = snapshot.data ?? [];
                          return UsersList(
                              users: users,
                              messageUsecase: widget.messageUsecase);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
