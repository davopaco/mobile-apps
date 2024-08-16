import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:users_list/users.dart';
import 'package:http/http.dart' as http;

class UsersList extends StatefulWidget {
  const UsersList({super.key});

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  Future<List<Users>> users() async {
    String sUrl = "https://api.npoint.io/bffbb3b6b3ad5e711dd2";
    try {
      List<Users> uList = [];
      final oResponse = await http.get(Uri.parse(sUrl),
          headers: {'Content-Type': 'application/json; charset=UTF-8'});
      dynamic oJsonData = jsonDecode(utf8.decode(oResponse.bodyBytes));
      for (final item in oJsonData["items"]) {
        uList.add(Users(
            fName: item["nombre"],
            career: item["carrera"],
            grade: item["promedio"],
            imagePath: 'images/${item["imagen"]}'));
      }
      return uList;
    } catch (error) {
      print("There was an error");
      print(error);
      rethrow;
    }
  }

  Widget userRow(String fName, String career, double grade, String imagePath) {
    return Container(
      height: 100,
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
              image: AssetImage(imagePath),
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
                fName,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                career,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                grade.toString(),
                style: const TextStyle(fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Widget> uList() async {
    try {
      final wUsers = await users();
      ListView list = ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: wUsers.length,
        itemBuilder: (BuildContext context, int index) {
          return userRow(wUsers[index].fName, wUsers[index].career,
              wUsers[index].grade, wUsers[index].imagePath);
        },
      );
      return Future.delayed(const Duration(seconds: 3), () => list);
    } catch (e) {
      print("There was an error while displaying the ListView widgets");
      print(e);
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
              future: uList(),
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
