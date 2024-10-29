import 'package:flutter/material.dart';

class GeneralButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final Function callback;

  const GeneralButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: color),
          onPressed: () {
            callback();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          )),
    );
  }
}
