import 'package:calculator/calc_button.dart';
import 'package:calculator/calc_model.dart';
import 'package:calculator/calc_display.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final CalculatorModel calculatorModel = CalculatorModel();
  final TextEditingController inputController =
      TextEditingController(text: "0");
  final TextEditingController inputController2 = TextEditingController();

  late Display display = Display(
      calculatorModel: calculatorModel,
      textEditingController: inputController,
      textEditingController2: inputController2);

  //Adding values to the display.
  void addValueDisplay(String value) {
    display.add(value);
  }

  //Clear Entry (CE)
  void clearValueDisplay() {
    inputController.text = "0";
    inputController2.text = "";
  }

  //All Clear (AC)
  void clearCalculator() {
    calculatorModel.clear();
    inputController.text = "0";
    inputController2.text = "";
  }

  //Operation on the display.
  void operationValueDisplay(String value) {
    display.operation(value: value);
  }

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
          //Main calculator container
          child: Container(
              padding: const EdgeInsets.all(23),
              width: 380,
              height: 570,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 8,
                        offset: Offset(0, 3))
                  ],
                  border: Border.all(color: const Color(0xFFC2C2C3), width: 4),
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
                  //Some blank space for padding.
                  const SizedBox(
                    height: 30,
                  ),
                  //The gray rounded container giving the hole illusion.
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
                      padding: const EdgeInsets.all(13),
                      //Container for both TextFields embedding.
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
                              boxShadow: const [
                                BoxShadow(color: Colors.grey, spreadRadius: 4)
                              ]),
                          child: Column(children: [
                            //Main TextField for numbers to show.
                            TextField(
                                textAlign: TextAlign.right,
                                enabled: false,
                                obscureText: false,
                                decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 7, horizontal: 14)),
                                style: const TextStyle(
                                    fontSize: 40,
                                    color: Colors.black,
                                    fontFamily: 'Courier'),
                                controller: inputController),
                            //Second TextField showing the current operators used.
                            TextField(
                                textAlign: TextAlign.right,
                                enabled: false,
                                obscureText: false,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'Courier'),
                                decoration: const InputDecoration(
                                    isDense: true,
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 3.0)),
                                controller: inputController2)
                          ]))),

                  //Padding between the display and the buttons.
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CalculatorButton(
                            symbol: "AC",
                            fCallBack: () => clearCalculator(),
                            buttonColour: const Color(0xFFF27141),
                            oForeColor: Colors.orange,
                          ),
                          CalculatorButton(
                            symbol: "CE",
                            fCallBack: () => clearValueDisplay(),
                            buttonColour: const Color(0xFFF27141),
                            oForeColor: Colors.orange,
                          ),
                          CalculatorButton(
                              symbol: "%",
                              fCallBack: () => operationValueDisplay("%")),
                          CalculatorButton(
                              symbol: "÷",
                              fCallBack: () => operationValueDisplay("÷")),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CalculatorButton(
                              symbol: "7",
                              fCallBack: () => addValueDisplay("7")),
                          CalculatorButton(
                              symbol: "8",
                              fCallBack: () => addValueDisplay("8")),
                          CalculatorButton(
                              symbol: "9",
                              fCallBack: () => addValueDisplay("9")),
                          CalculatorButton(
                              symbol: "x",
                              fCallBack: () => operationValueDisplay("x")),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CalculatorButton(
                              symbol: "4",
                              fCallBack: () => addValueDisplay("4")),
                          CalculatorButton(
                              symbol: "5",
                              fCallBack: () => addValueDisplay("5")),
                          CalculatorButton(
                              symbol: "6",
                              fCallBack: () => addValueDisplay("6")),
                          CalculatorButton(
                              symbol: "-",
                              fCallBack: () => operationValueDisplay("-"))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: [
                              CalculatorButton(
                                  symbol: "1",
                                  fCallBack: () => addValueDisplay("1")),
                              CalculatorButton(
                                  symbol: "0",
                                  fCallBack: () => addValueDisplay("0")),
                            ],
                          ),
                          Column(
                            children: [
                              CalculatorButton(
                                  symbol: "2",
                                  fCallBack: () => addValueDisplay("2")),
                              CalculatorButton(
                                  symbol: ".",
                                  fCallBack: () => addValueDisplay(".")),
                            ],
                          ),
                          Column(
                            children: [
                              CalculatorButton(
                                  symbol: "3",
                                  fCallBack: () => addValueDisplay("3")),
                              CalculatorButton(
                                  symbol: "=",
                                  fCallBack: () => operationValueDisplay("=")),
                            ],
                          ),
                          Column(
                            children: [
                              CalculatorButton(
                                  symbol: "+",
                                  fCallBack: () => operationValueDisplay("+")),
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
