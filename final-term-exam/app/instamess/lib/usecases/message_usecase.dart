import 'package:instamess/model/interfaces/message_to_send.dart';
import 'package:instamess/model/interfaces/message_with_user.dart';
import 'package:instamess/model/message.dart';
import 'package:instamess/model/user.dart';
import 'package:instamess/services/message_service.dart';
import 'package:instamess/services/user_service.dart';

class MessageUsecase {
  final MessageService _messageService;
  final UserService _userService;

  MessageUsecase(
      {required MessageService messageService,
      required UserService userService})
      : _messageService = messageService,
        _userService = userService;

  Future<List<MessageWithUser>> getMessages() async {
    List<Message> messages = await _messageService.getMessages();

    List<MessageWithUser> messagesWithUsers = [];
    messages.forEach((message) async {
      User sender = await _userService.getUserByEmail(message.senderEmail);
      messagesWithUsers.add(MessageWithUser(message: message, user: sender));
    });

    return messagesWithUsers;
  }

  Future<void> addMessage(MessageToSend messageToSend) async {
    return await _messageService.sendMessage(messageToSend);
  }
}
