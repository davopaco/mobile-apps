import 'package:flutter/material.dart';
import 'package:quiz1/users.dart';

class UserDetails extends StatelessWidget {
  final Users user;

  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(user.fName),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Image(
                    image: NetworkImage(user.imagePath),
                    height: 200,
                    width: 200,
                  )),
              SizedBox(
                height: 20,
              ),
              Text(user.fName),
              Text(user.career),
              Text(user.age.toString()),
              Text(user.university),
              Text(user.highSchool),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 0, horizontal: 0))),
                child: const Text(
                  "< Regresar",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
