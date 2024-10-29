import 'package:instamess/model/message.dart';
import 'package:instamess/model/user.dart';

class MessageWithUser {
  Message message;
  User user;

  MessageWithUser({required this.message, required this.user});
}
