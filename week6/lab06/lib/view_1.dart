import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab06/view_2_3.dart';

class View1 extends StatefulWidget {
  const View1({super.key});

  @override
  State<View1> createState() => _View1State();
}

class _View1State extends State<View1> {
  String value = "";

  void checkParams(String response) {
    if (response == "mundo") {
      setState(() {
        value = response;
      });
    }
  }

  Future<void> _navigateToView2Push(BuildContext context) async {
    final response = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const View2(params: "hola")));
    checkParams(response);
  }

  Future<void> _navigateToView2PushNamed(BuildContext context) async {
    final response = await Navigator.pushNamed(context, '/view2');
    checkParams(response as String);
  }

  Future<void> _navigateToView3GetTo() async {
    final response = await Get.to(const View3(params: "hola"));
    checkParams(response as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista 1'),
      ),
      body: Center(
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 10, 141, 146),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 300,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Vista 2',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _navigateToView2Push(context);
                      },
                      child: const Text('push',
                          style: TextStyle(
                            fontSize: 20,
                          ))),
                  ElevatedButton(
                      onPressed: () {
                        _navigateToView2PushNamed(context);
                      },
                      child: const Text(
                        'pushNamed',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                  const SizedBox(height: 40),
                  const Text(
                    'Vista 3',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _navigateToView3GetTo();
                      },
                      child: const Text('Get.to',
                          style: TextStyle(
                            fontSize: 20,
                          ))),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: value,
                    ),
                  )
                ],
              ))),
    );
  }
}
