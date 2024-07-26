import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

Widget calculatorButtonBlack(String symbol) {
  ButtonStyle initialElevatedButtonStyle;
  if (symbol == "AC" || symbol == "CE") {
    initialElevatedButtonStyle =
        ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF27141));
  } else {
    initialElevatedButtonStyle =
        ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5A5A5A));
  }

  ButtonStyle elevatedButtonStyle = initialElevatedButtonStyle.copyWith(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));

  return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () => print(symbol),
        style: elevatedButtonStyle,
        child: Text(symbol,
            style: const TextStyle(
              color: Colors.white,
            )),
      ));
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Mi calculadora"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      calculatorButtonBlack("AC"),
                      calculatorButtonBlack("CE"),
                      calculatorButtonBlack("%"),
                      calculatorButtonBlack("/"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      calculatorButtonBlack("7"),
                      calculatorButtonBlack("8"),
                      calculatorButtonBlack("9"),
                      calculatorButtonBlack("x"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      calculatorButtonBlack("4"),
                      calculatorButtonBlack("5"),
                      calculatorButtonBlack("6"),
                      calculatorButtonBlack("-")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          calculatorButtonBlack("1"),
                          calculatorButtonBlack("0")
                        ],
                      ),
                      Column(
                        children: [
                          calculatorButtonBlack("2"),
                          calculatorButtonBlack(".")
                        ],
                      ),
                      Column(
                        children: [
                          calculatorButtonBlack("3"),
                          calculatorButtonBlack("=")
                        ],
                      ),
                      Column(
                        children: [
                          calculatorButtonBlack("+"),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
