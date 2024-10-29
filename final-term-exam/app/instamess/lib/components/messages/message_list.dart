import 'package:flutter/material.dart';
import 'package:instamess/components/messages/message_pod.dart';
import 'package:instamess/model/interfaces/message_with_user.dart';
import 'package:instamess/usecases/message_usecase.dart';

class MessagesList extends StatefulWidget {
  final List<MessageWithUser> messagesWithUser;
  final MessageUsecase messageUsecase;

  const MessagesList(
      {super.key,
      required this.messagesWithUser,
      required this.messageUsecase});

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.messagesWithUser.length,
      itemBuilder: (BuildContext context, int index) {
        return MessagePod(
            messageWithUser: widget.messagesWithUser[index],
            messageUsecase: widget.messageUsecase);
      },
    );
  }
}
