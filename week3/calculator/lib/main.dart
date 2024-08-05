import 'package:calculator/calculadora.dart';
import 'package:calculator/calculator_model.dart';
import 'package:calculator/display.dart';
import 'package:flutter/material.dart';

void main() {
  final CalculatorModel calculatorModel = CalculatorModel();
  final TextEditingController inputController = TextEditingController();

  Display display = Display(
      calculatorModel: calculatorModel, textEditingController: inputController);
  runApp(Calculator(
      calculatorModel: calculatorModel,
      display: display,
      textEditingController: inputController));
}
