import 'package:calculator/calc_model.dart';
import 'package:calculator/calc_operations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Display {
  int limit;
  int nchars;
  final CalculatorModel calculatorModel;
  final TextEditingController textEditingController;
  final TextEditingController textEditingController2;

  Display(
      {this.limit = 10,
      this.nchars = 0,
      required this.calculatorModel,
      required this.textEditingController,
      required this.textEditingController2}) {}

  //Function for formatting double numbers in case of exceptions or integers.
  String formatDouble(double value) {
    try {
      if (value == value.toInt()) {
        return value.toInt().toString();
      } else {
        return value.toString();
      }
    } catch (e) {
      return value.toString();
    }
  }

  //A boolean that describes if the calculator may have more digits on the display.
  bool go() {
    return nchars < limit;
  }

  //For clearing the display and number of characters.
  void clear() {
    textEditingController.text = "";
    nchars = 0;
  }

  //For adding numbers and the dot.
  void add(String value) {
    //Used for checking if it's a new number.
    if (calculatorModel.newNumber == true) {
      clear();
      calculatorModel.newNumber = false;
    }
    if (go()) {
      //Zero checker
      if (textEditingController.text == "0" && value != ".") {
        clear();
      }
      //Double dot inhibiter
      if (textEditingController.text.contains(".") && value == ".") {
        return;
      }
      //Dot checker
      if (textEditingController.text == ".") {
        textEditingController.text = "0.";
        nchars = 0;
      }
      //Appends characters
      textEditingController.text = "${textEditingController.text}$value";
      nchars++;
    }
  }

  //Operator checker
  void checkOperator(String operator) {
    switch (operator) {
      case "+":
        textEditingController2.text = "Addition +";
      case "-":
        textEditingController2.text = "Substraction -";
      case "x":
        textEditingController2.text = "Multiplication x";
      case "÷":
        textEditingController2.text = "Division ÷";
      case "%":
        textEditingController2.text = "Percentage %";
      case "=":
        textEditingController2.text = "Equals =";
      default:
        textEditingController2.text = "";
    }
  }

  //For operations
  void operation({required String value, bool equals = false}) {
    //Checks for a minus that's not an operator.
    if (double.tryParse(calculatorModel.peek()) == null &&
        calculatorModel.peek() != "") {
      if (value == "-" && !equals) {
        calculatorModel.newNumber = true;
        add("-");
        return;
      }
    }

    //For showing the operation on the second display.
    if (!equals) checkOperator(value);

    String result = textEditingController.text;

    //Where operations are done
    if (!calculatorModel.isEmpty() ||
        double.tryParse(calculatorModel.peek()) is double) {
      //a and b are both numbers
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

      //Checking what operations are being done.
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
          //Uses recursion for making the final operation in memory.
          final value2 = calculatorModel.peek();
          if (double.tryParse(value2) == null) {
            operation(value: value2, equals: true);
          }
          calculatorModel.clear();
          return;
      }
    }

    //Scientific notation checker
    if (value != "=") {
      if (result.length > 10) {
        textEditingController.text =
            double.parse(result).toStringAsExponential(3);
        return;
      }
      textEditingController.text = formatDouble(double.parse(result));
    }

    //Pushing numbers and operations to the calculator memory.
    calculatorModel.push(textEditingController.text);
    calculatorModel.push(value);
    calculatorModel.newNumber = true;
  }
}
