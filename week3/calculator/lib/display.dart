import 'package:calculator/calculator_model.dart';
import 'package:calculator/operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Display {
  int limit;
  int nchars;
  final CalculatorModel calculatorModel;
  final TextEditingController textEditingController;

  Display(
      {this.limit = 10,
      this.nchars = 0,
      required this.calculatorModel,
      required this.textEditingController});

  String formatDouble(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    } else {
      return value.toString();
    }
  }

  bool go() {
    return nchars < limit;
  }

  void clear() {
    textEditingController.text = "";
    nchars = 0;
  }

  void add(String value) {
    if (calculatorModel.newNumber == true) {
      clear();
      calculatorModel.newNumber = false;
    }
    if (go()) {
      if (textEditingController.text == "0" && value != ".") {
        clear();
      }
      if (textEditingController.text.contains(".") && value == ".") {
        return;
      }
      if (textEditingController.text == ".") {
        textEditingController.text = "0.";
        nchars = 0;
      }
      textEditingController.text = "${textEditingController.text}$value";
      nchars++;
    }
  }

  void back() {
    if (textEditingController.text.isNotEmpty) {
      textEditingController.text = textEditingController.text.substring(0, -1);
    }
  }

  void operation({required String value, bool equals = false}) {
    if (value == "-") {
      if (textEditingController.text.isEmpty) {
        textEditingController.text = "-";
        return;
      }
    }

    if (textEditingController.text.isEmpty) return;

    String result = textEditingController.text;

    if (!calculatorModel.isEmpty() ||
        double.tryParse(calculatorModel.peek()) is double) {
      double a = double.parse(calculatorModel.peekBefore());
      double b = double.parse(textEditingController.text);
      Operations operations = Operations(a: a, b: b);
      String actualValue = "";

      if (value == "=") {
        actualValue = "=";
      } else if (equals) {
        actualValue = value;
      } else {
        actualValue = calculatorModel.peek();
      }

      switch (actualValue) {
        case "+":
          result = operations.add().toString();
        case "-":
          result = operations.substract().toString();
        case "x":
          result = operations.multiply().toString();
        case "÷":
          result = operations.divide().toString();
        case "%":
          result = operations.percentage().toString();
        case "=":
          final value2 = calculatorModel.peek();
          if (double.tryParse(value2) == null) {
            operation(value: value2, equals: true);
          }
          calculatorModel.clear();
          return;
      }
    }
    if (value != "=") {
      if (result.length > 10) {
        textEditingController.text =
            double.parse(result).toStringAsExponential(3);
        return;
      }
      textEditingController.text = formatDouble(double.parse(result));
    }
    calculatorModel.push(textEditingController.text);
    calculatorModel.push(value);
    calculatorModel.newNumber = true;
  }
}
