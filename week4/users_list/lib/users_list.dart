import 'package:flutter/material.dart';
import 'package:users_list/users.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  List<Users> users() {
    return [
      Users(
          fName: "David Cárdenas",
          career: "Ingeniería de Sistemas",
          grade: "2.0"),
      Users(
          fName: "Sofía Salas", career: "Ingeniería de Sistemas", grade: "1.9"),
      Users(
          fName: "Alexandra Bernal",
          career: "Ingeniería de Sistemas",
          grade: "5.0"),
      Users(fName: "Fabiana Cadavid", career: "Diseño Gráfico", grade: "3.0")
    ];
  }

  Widget userRow(String fName, String career, String grade) {
    return Container(
      height: 100,
      color: Colors.transparent,
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 18,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fName,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                career,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                grade,
                style: const TextStyle(fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Users List'),
        ),
        body: Center(
          child: ListView.builder(
            padding: EdgeInsets.all(18),
            itemCount: users().length,
            itemBuilder: (BuildContext context, int index) {
              return userRow(users()[index].fName, users()[index].career,
                  users()[index].grade);
            },
          ),
        ),
      ),
    );
  }
}
