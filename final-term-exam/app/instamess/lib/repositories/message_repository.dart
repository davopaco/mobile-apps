import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:instamess/model/message.dart';

class MessageRepository {
  final hostEndpoint =
      '${dotenv.env['HOST'] ?? 'http://localhost'}:${dotenv.env['PORT'] ?? '3000'}/message';

  Future<List<Message>> getMessages() async {
    String route = '$hostEndpoint/all';

    final response = await http.get(Uri.parse(route));
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
}
