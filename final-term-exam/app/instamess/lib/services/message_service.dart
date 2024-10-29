import 'package:instamess/model/interfaces/message_to_send.dart';
import 'package:instamess/model/message.dart';
import 'package:instamess/repositories/message_repository.dart';

class MessageService {
  final MessageRepository _messageRepository;

  MessageService({required MessageRepository messageRepository})
      : _messageRepository = messageRepository;

  Future<List<Message>> getMessages() async {
    return await _messageRepository.getMessages();
  }

  Future<dynamic> sendMessage(MessageToSend messageToSend) async {
    return await _messageRepository.sendMessage(messageToSend);
  }
}
