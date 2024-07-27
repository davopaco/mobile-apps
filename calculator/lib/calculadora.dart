import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

Widget calculatorButton(String symbol) {
  Color buttonColour;
  RadialGradient buttonGradient;

  if (symbol == "AC" || symbol == "CE") {
    buttonColour = const Color(0xFFF27141);
    buttonGradient = RadialGradient(
        center: const Alignment(0, -1),
        radius: 1,
        colors: <Color>[
          buttonColour,
          buttonColour,
        ]);
  } else {
    buttonColour = const Color(0xFF5A5A5A);
    buttonGradient = RadialGradient(
        center: const Alignment(0, -1),
        radius: 1,
        colors: <Color>[buttonColour, buttonColour, buttonColour, Colors.grey]);
  }

  ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(8),
      backgroundColor: Colors.transparent);

  if (symbol == "+") {
    elevatedButtonStyle = elevatedButtonStyle.copyWith(
      minimumSize: WidgetStateProperty.all(const Size(60, 110)),
      maximumSize: WidgetStateProperty.all(const Size(60, 110)),
    );
  } else {
    elevatedButtonStyle = elevatedButtonStyle.copyWith(
      minimumSize: WidgetStateProperty.all(const Size(60, 50)),
      maximumSize: WidgetStateProperty.all(const Size(60, 50)),
    );
  }

  return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white, width: 1)),
              boxShadow: [
                BoxShadow(color: Colors.black, spreadRadius: 1, blurRadius: 2)
              ],
              borderRadius: BorderRadius.circular(10),
              gradient: buttonGradient),
          child: ElevatedButton(
              onPressed: () => print(symbol),
              style: elevatedButtonStyle,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(symbol,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Roboto')),
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
              width: 380,
              height: 560,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 8,
                        offset: Offset(0, 3))
                  ],
                  border: Border.all(color: Color(0xFFC2C2C3), width: 4),
                  borderRadius: BorderRadius.circular(29),
                  gradient: const RadialGradient(
                    center: Alignment(-1, -1),
                    radius: 0.7,
                    colors: <Color>[Color(0xFFEFEEEF), Color(0xFFD1D0D0)],
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromARGB(255, 112, 112, 112)
                                    .withOpacity(0.5),
                                const Color.fromARGB(255, 221, 212, 212)
                                    .withOpacity(0.5)
                              ])),
                      padding: EdgeInsets.all(13),
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFFBBBF99),
                                    Color.fromARGB(255, 170, 178, 136)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.4),
                                  width: 1),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: Colors.grey, spreadRadius: 4)
                              ]),
                          child: TextField(
                            textAlign: TextAlign.center,
                            enabled: false,
                            obscureText: false,
                            style: const TextStyle(
                                fontSize: 40,
                                color: Colors.black,
                                fontFamily: 'Courier'),
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(16),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                fillColor: Colors.transparent),
                            controller:
                                TextEditingController(text: "0123456789"),
                          ))),
                  const SizedBox(height: 20),
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
                          calculatorButton("÷"),
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
