import 'package:flutter/material.dart';
import 'package:instamess/components/item_circular_button.dart';
import 'package:instamess/components/messages/message_list.dart';
import 'package:instamess/components/sliding_menu.dart';
import 'package:instamess/usecases/login_usecase.dart';
import 'package:instamess/usecases/message_usecase.dart';

class MessagesView extends StatefulWidget {
  final LoginUseCase loginUsecase;
  final MessageUsecase messageUsecase;

  const MessagesView(
      {super.key, required this.messageUsecase, required this.loginUsecase});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
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
                          'Mensajes recibidos',
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
                          icon: const Icon(Icons.menu),
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
                      future: widget.messageUsecase.getMessages(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No messages found');
                        } else {
                          final messagesWithUser = snapshot.data ?? [];
                          return MessagesList(
                              messagesWithUser: messagesWithUser,
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
