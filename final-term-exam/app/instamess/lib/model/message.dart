class Message {
  int id;
  String title;
  String content;
  String date;
  String time;
  String senderEmail;
  String recipientEmail;

  Message(
      {required this.id,
      required this.title,
      required this.content,
      required this.date,
      required this.time,
      required this.senderEmail,
      required this.recipientEmail});

  factory Message.fromJson(Map<String, dynamic> json) {
    List<String> fullDate = json['date'].split(', ');
    String date = fullDate[0];
    final time = fullDate[1].split(' ');
    String formattedTime =
        "${time[0].split(":").sublist(0, 2).join(":")} ${time[1]}";

    return Message(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        date: date,
        time: formattedTime,
        senderEmail: json['senderEmail'],
        recipientEmail: json['recipientEmail']);
  }
}
