import 'package:flutter/material.dart';

class AbstractView extends StatelessWidget {
  final String params;
  final int viewIndex;

  const AbstractView(
      {super.key, required this.params, required this.viewIndex});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vista $viewIndex'),
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
                      'Vista 1',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, "mundo");
                        },
                        child: const Text('Regresar a la vista 1',
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                    const SizedBox(height: 40),
                    SizedBox(
                        width: 150,
                        child: TextField(
                          enabled: false,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                          ),
                          controller: TextEditingController(text: params),
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ))
                  ],
                ))),
      ),
    );
  }
}
