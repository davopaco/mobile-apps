import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String sTag;
  final Function fCallBack;
  final Color oColor;
  final Color oForeColor;

  const CalculatorButton({
    super.key,
    required this.sTag,
    required this.fCallBack,
    this.oColor = Colors.black,
    this.oForeColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(10));
  }
}
