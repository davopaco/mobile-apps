import 'package:flutter/material.dart';
import 'package:users_list/users.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  List<Users> users() {
    return [
      Users(
          fName: "David Cárdenas",
          career: "Ingeniería de Sistemas",
          grade: "2.0",
          imagePath: "images/santiago.jpg"),
      Users(
          fName: "Sofía Salas",
          career: "Ingeniería de Sistemas",
          grade: "1.9",
          imagePath: "images/sofia.jpg"),
      Users(
          fName: "Alexandra Bernal",
          career: "Ingeniería de Sistemas",
          grade: "5.0",
          imagePath: "images/a.jpeg"),
      Users(
          fName: "Fabiana Cadavid",
          career: "Diseño Gráfico",
          grade: "3.0",
          imagePath: "images/fabiana.jpg"),
      Users(
          fName: "Gabriel Reyes",
          career: "Comunicación Social",
          grade: "3.5",
          imagePath: "images/gabriel.jpg"),
      Users(
          fName: "Juan Pérez",
          career: "Ingeniería de Sistemas",
          grade: "3.5",
          imagePath: "images/1.jpg"),
      Users(
          fName: "María Rodríguez",
          career: "Administración de Empresas",
          grade: "4.0",
          imagePath: "images/2.jpg"),
      Users(
          fName: "Carlos Martínez",
          career: "Derecho",
          grade: "3.8",
          imagePath: "images/3.jpg"),
      Users(
          fName: "Ana Gómez",
          career: "Medicina",
          grade: "4.2",
          imagePath: "images/4.jpg"),
      Users(
          fName: "Luis Ramírez",
          career: "Ingeniería Civil",
          grade: "3.2",
          imagePath: "images/5.jpg"),
      Users(
          fName: "Laura Torres",
          career: "Psicología",
          grade: "4.5",
          imagePath: "images/6.jpg"),
      Users(
          fName: "Pedro Hernández",
          career: "Economía",
          grade: "3.9",
          imagePath: "images/7.jpg"),
      Users(
          fName: "Sofía Sánchez",
          career: "Arquitectura",
          grade: "4.1",
          imagePath: "images/8.jpg"),
      Users(
          fName: "Diego Jiménez",
          career: "Comunicación Social",
          grade: "3.7",
          imagePath: "images/9.jpg"),
      Users(
          fName: "Isabel Castillo",
          career: "Diseño Gráfico",
          grade: "4.3",
          imagePath: "images/10.jpg"),
      Users(
          fName: "Andrés Morales",
          career: "Ingeniería Industrial",
          grade: "3.6",
          imagePath: "images/11.jpg"),
      Users(
          fName: "Catalina Romero",
          career: "Nutrición y Dietética",
          grade: "4.0",
          imagePath: "images/12.jpg"),
      Users(
          fName: "Ricardo Ortiz",
          career: "Contaduría Pública",
          grade: "3.8",
          imagePath: "images/13.jpg"),
      Users(
          fName: "Valeria Mendoza",
          career: "Ingeniería Química",
          grade: "4.4",
          imagePath: "images/14.jpg"),
      Users(
          fName: "Sebastián Guerrero",
          career: "Biología",
          grade: "3.5",
          imagePath: "images/15.jpg"),
    ];
  }

  Widget userRow(String fName, String career, String grade, String imagePath) {
    return Container(
      height: 100,
      color: Colors.transparent,
      child: Row(
        children: [
          Image(
            image: AssetImage(imagePath),
            height: 80,
            width: 80,
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
            padding: const EdgeInsets.all(18),
            itemCount: users().length,
            itemBuilder: (BuildContext context, int index) {
              return userRow(users()[index].fName, users()[index].career,
                  users()[index].grade, users()[index].imagePath);
            },
          ),
        ),
      ),
    );
  }
}
