class MessageToSend {
  String title;
  String content;
  String recipientEmail;

  MessageToSend(
      {required this.title,
      required this.content,
      required this.recipientEmail});

  toJson() {
    return {
      'title': title,
      'content': content,
      'recipientEmail': recipientEmail,
    };
  }
}
