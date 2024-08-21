import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz1/user_detail.dart';
import 'package:quiz1/users.dart';

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  //Method for getting the async list of users (future).
  Future<List<Users>> users() async {
    String sUrl = "https://api.npoint.io/5cb393746e518d1d8880";
    try {
      List<Users> uList = [];
      final oResponse = await http.get(Uri.parse(sUrl),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      dynamic oJsonData = jsonDecode(utf8.decode(oResponse.bodyBytes));
      for (final item in oJsonData["elementos"]) {
        uList.add(Users(
            fName: item["nombreCompleto"],
            career: item["profesion"],
            university: item["estudios"][0]["universidad"],
            imagePath: item["urlImagen"],
            age: item["edad"],
            highSchool: item["estudios"][0]["bachillerato"]));
      }
      return uList;
    } catch (error) {
      print("There was an error: $error");
      rethrow;
    }
  }

  //Returns the container with the user's info.
  Widget userRow(Users user, BuildContext context) {
    return Container(
      height: 135,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black, width: 1)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image(
              image: NetworkImage(user.imagePath),
              height: 80,
              width: 80,
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fName,
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                user.career,
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                user.university,
                style: const TextStyle(fontSize: 15),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserDetails(user: user)));
                },
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 0, horizontal: 0))),
                child: const Text(
                  "Ver perfil",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  //Returns a future of a widget.
  Future<Widget> uList(BuildContext context) async {
    try {
      final wUsers = await users();
      ListView list = ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: wUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return userRow(wUsers[index], context);
        },
      );
      return Future.delayed(const Duration(seconds: 3), () => list);
    } catch (e) {
      print("There was an error while displaying the ListView widgets $e");
      return const Text("No data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Users List'),
          ),
          body: FutureBuilder<Widget>(
              future: uList(context),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data ?? Container();
                }
                return const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Loading information from the internet.")
                  ],
                ));
              })),
    );
  }
}
