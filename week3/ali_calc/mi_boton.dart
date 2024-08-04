
 
import 'package:flutter/material.dart';

class MiBoton extends StatelessWidget {
  
  final String sEtiqueta;
  final Function fCallBack;
  final Color oColor;
  final Color oForeColor;
  
  const MiBoton(
    {
      super.key,
      required this.sEtiqueta,
      required this.fCallBack,
      this.oColor = Colors.black,
      this.oForeColor = Colors.white
    }
  );
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5,0,5,0),
      child: 
      TextButton(
        onPressed: () => fCallBack(sEtiqueta),
        style: ElevatedButton.styleFrom(backgroundColor: oColor),
        child: Text(sEtiqueta, style: TextStyle(color: oForeColor)),
      ),
    );
  }
}
