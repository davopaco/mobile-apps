import 'package:flutter/material.dart';
import 'package:instamess/components/general_button.dart';
import 'package:instamess/components/general_textf.dart';
import 'package:instamess/model/interfaces/message_to_send.dart';
import 'package:instamess/usecases/message_usecase.dart';

class MessageModal extends StatelessWidget {
  final MessageUsecase messageUsecase;
  final String recipientEmail;

  const MessageModal(
      {super.key, required this.messageUsecase, required this.recipientEmail});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 122, 122, 122),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Enviar mensaje',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GeneralTextField(labelText: "Título", eController: titleController),
            const SizedBox(height: 10),
            GeneralTextField(
                labelText: "Mensaje", eController: messageController),
            const SizedBox(height: 20),
            GeneralButton(
                title: "Enviar",
                icon: Icons.send_rounded,
                color: Colors.green,
                callback: () async {
                  final MessageToSend message = MessageToSend(
                    title: titleController.text,
                    content: messageController.text,
                    recipientEmail: recipientEmail,
                  );
                  await messageUsecase.addMessage(message);
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
