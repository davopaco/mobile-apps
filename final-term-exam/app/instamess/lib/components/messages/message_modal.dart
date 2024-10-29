import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instamess/components/general_textf.dart';

class MessageModal extends StatelessWidget {
  const MessageModal({super.key});

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enviar mensaje',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GeneralTextField(labelText: "Título", eController: titleController),
            const SizedBox(height: 10),
            GeneralTextField(
                labelText: "Mensaje", eController: messageController),
          ],
        ),
      ),
    );
  }
}
