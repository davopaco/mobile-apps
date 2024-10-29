import 'package:instamess/model/message.dart';
import 'package:instamess/repositories/message_repository.dart';

class MessageService {
  final MessageRepository _messageRepository;

  MessageService({required MessageRepository messageRepository})
      : _messageRepository = messageRepository;

  Future<List<Message>> getMessages() async {
    return await _messageRepository.getMessages();
  }

  Future<dynamic> sendMessage(
      {required String title,
      required String content,
      required String recipientEmail}) async {
    return await _messageRepository.sendMessage(
        title: title, content: content, recipientEmail: recipientEmail);
  }
}
