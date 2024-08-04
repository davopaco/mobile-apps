import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String symbol;
  final Function fCallBack;
  final Color buttonColour;
  final Color oForeColor;

  const CalculatorButton(
      {super.key,
      required this.symbol,
      required this.fCallBack,
      this.buttonColour = const Color(0xFF5A5A5A),
      this.oForeColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    RadialGradient buttonGradient = RadialGradient(
        radius: 1,
        center: const Alignment(0, -1),
        colors: <Color>[buttonColour, buttonColour, oForeColor]);

    ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.transparent);

    if (symbol == "+") {
      elevatedButtonStyle = elevatedButtonStyle.copyWith(
        minimumSize: WidgetStateProperty.all(const Size(60, 115)),
        maximumSize: WidgetStateProperty.all(const Size(60, 115)),
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
                border: const Border(
                    top: BorderSide(color: Colors.white, width: 1)),
                boxShadow: const [
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
}
