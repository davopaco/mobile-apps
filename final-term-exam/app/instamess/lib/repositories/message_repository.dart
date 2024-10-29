import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:instamess/model/interfaces/message_to_send.dart';
import 'package:instamess/model/message.dart';
import 'package:instamess/repositories/login_repository.dart';

class MessageRepository {
  final LoginRepository _loginRepository;

  MessageRepository({required LoginRepository loginRepository})
      : _loginRepository = loginRepository;

  final hostEndpoint =
      '${dotenv.env['HOST'] ?? 'http://localhost'}:${dotenv.env['PORT'] ?? '3000'}/message';

  Future<List<Message>> getMessages() async {
    String route = '$hostEndpoint/all';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _loginRepository.getToken()}',
    };

    final response = await http.get(Uri.parse(route), headers: headers);
    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      List<dynamic> messagesJson = jsonResponse['messages'];
      List<Message> messages = [];
      for (var messageJson in messagesJson) {
        messages.add(Message.fromJson(messageJson));
      }
      return messages;
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<dynamic> sendMessage(MessageToSend messageToSend) async {
    String route = '$hostEndpoint/send';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await _loginRepository.getToken()}',
    };

    final response = await http.post(Uri.parse(route),
        headers: headers, body: jsonEncode(messageToSend.toJson()));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send message');
    }
  }
}
