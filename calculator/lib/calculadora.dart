import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

Widget calculatorButton(String symbol) {
  Color buttonColour;
  if (symbol == "AC" || symbol == "CE") {
    buttonColour = const Color(0xFFF27141);
  } else {
    buttonColour = const Color(0xFF5A5A5A);
  }

  ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      minimumSize: const Size(60, 50),
      maximumSize: const Size(60, 50),
      padding: const EdgeInsets.all(8),
      backgroundColor: Colors.transparent);

  return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: RadialGradient(
                  center: const Alignment(0, -1),
                  radius: 1,
                  colors: <Color>[
                    buttonColour,
                    buttonColour,
                    buttonColour,
                    Colors.grey
                  ])),
          child: ElevatedButton(
              onPressed: () => print(symbol),
              style: elevatedButtonStyle,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(symbol,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.normal)),
              ))));
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
              padding: const EdgeInsets.all(23),
              width: 350,
              height: 500,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(color: Colors.grey, blurRadius: 5),
                    BoxShadow(color: Colors.black, blurRadius: 5)
                  ],
                  borderRadius: BorderRadius.circular(20),
                  gradient: const RadialGradient(
                    center: Alignment(-1, -1),
                    radius: 0.7,
                    colors: <Color>[
                      Color.fromARGB(255, 238, 239, 238),
                      Color.fromARGB(255, 211, 211, 210)
                    ],
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const TextField(
                    enabled: true,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: '0123456789'),
                  ),
                  const SizedBox(
                    height: 30,
                    width: 100,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          calculatorButton("AC"),
                          calculatorButton("CE"),
                          calculatorButton("%"),
                          calculatorButton("/"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          calculatorButton("7"),
                          calculatorButton("8"),
                          calculatorButton("9"),
                          calculatorButton("x"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          calculatorButton("4"),
                          calculatorButton("5"),
                          calculatorButton("6"),
                          calculatorButton("-")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: [
                              calculatorButton("1"),
                              calculatorButton("0")
                            ],
                          ),
                          Column(
                            children: [
                              calculatorButton("2"),
                              calculatorButton(".")
                            ],
                          ),
                          Column(
                            children: [
                              calculatorButton("3"),
                              calculatorButton("=")
                            ],
                          ),
                          Column(
                            children: [
                              calculatorButton("+"),
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              )),
        ),
      ),
    ));
  }
}
