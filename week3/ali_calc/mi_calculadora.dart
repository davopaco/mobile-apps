
import 'package:flutter/material.dart';

import 'mi_boton.dart';

class MiCalculadora extends StatefulWidget {
  const MiCalculadora({super.key});

  @override
  State<MiCalculadora> createState() => _MiCalculadoraState();
}

class _MiCalculadoraState extends State<MiCalculadora> {

  final TextEditingController _oControladorInput = TextEditingController();
  
  void _ejecutarFuncionEspecial(String sEtiqueta){
    if (sEtiqueta == "AC"){
      _oControladorInput.text = "";
    } else if (sEtiqueta == "CE"){
      _oControladorInput.text = "";
    }
  } //_ejecutarFuncionEspecial
  
  void _actualizarPantallaCalculadora(String sEtiqueta){
    _oControladorInput.text = "${_oControladorInput.text}$sEtiqueta";
  } //_actualizarPantallaCalculadora
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi calculadora'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _oControladorInput,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Entrada',
            ),
          ),
          /*
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            ESTAS SON FORMAS EQUIVALENTES DE LLAMADAS DE CALLBACK:
            
            children: [
              MiBoton(
                fCallBack: (a, b) => _actualizarPantallaCalculadora(a, b),
                sEtiqueta: "4",
              ),
              MiBoton(
                fCallBack: (a, b) => _actualizarPantallaCalculadora(a, b),
                sEtiqueta: "4",
              ),
              MiBoton(
                fCallBack: (a, b) => _actualizarPantallaCalculadora(a, b),
                sEtiqueta: "4",
              ),
              MiBoton(
                fCallBack: (a) => _actualizarPantallaCalculadora(a, a),
                sEtiqueta: "4",
              ),
            ],
          ),
          */
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MiBoton(
                fCallBack: (String sEtiqueta) => _ejecutarFuncionEspecial(sEtiqueta),
                sEtiqueta: "AC",
                oColor: Colors.orange,
                oForeColor: Colors.black,
              ),
              MiBoton(
                fCallBack: (String sEtiqueta) => _ejecutarFuncionEspecial(sEtiqueta),
                sEtiqueta: "CE",
                oColor: Colors.orange,
                oForeColor: Colors.black,
              ),
              MiBoton(
                fCallBack: (String sEtiqueta) => _actualizarPantallaCalculadora(sEtiqueta),
                sEtiqueta: "%",
              ),
              MiBoton(
                fCallBack: (String sEtiqueta) => _actualizarPantallaCalculadora(sEtiqueta),
                sEtiqueta: "/",
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,

            //EN ESTA FILA LES DEJO 4 FORMAS EQUIVALENTES PARA PASAR LA FUNCIÓN DE RETORNO AL CONSTRUCTOR DE MiBoton
            //EN ESTA FILA LES DEJO 4 FORMAS EQUIVALENTES PARA PASAR LA FUNCIÓN DE RETORNO AL CONSTRUCTOR DE MiBoton
            //EN ESTA FILA LES DEJO 4 FORMAS EQUIVALENTES PARA PASAR LA FUNCIÓN DE RETORNO AL CONSTRUCTOR DE MiBoton
            //EN ESTA FILA LES DEJO 4 FORMAS EQUIVALENTES PARA PASAR LA FUNCIÓN DE RETORNO AL CONSTRUCTOR DE MiBoton
            children: [
              MiBoton(
                fCallBack: ((String sEtiqueta){ return _actualizarPantallaCalculadora(sEtiqueta); }),
                sEtiqueta: "7",
              ),
              MiBoton(
                fCallBack: (String sEtiqueta){ return _actualizarPantallaCalculadora(sEtiqueta); },
                sEtiqueta: "8",
              ),
              MiBoton(
                fCallBack: (String sEtiqueta){ _actualizarPantallaCalculadora(sEtiqueta); },
                sEtiqueta: "9",
              ),
              MiBoton(
                fCallBack: (String sEtiqueta) => _actualizarPantallaCalculadora(sEtiqueta),
                sEtiqueta: "x",
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MiBoton(
                fCallBack: (String sEtiqueta) => _ejecutarFuncionEspecial(sEtiqueta),
                sEtiqueta: "4",
              ),
              MiBoton(
                fCallBack: (String sEtiqueta) => _ejecutarFuncionEspecial(sEtiqueta),
                sEtiqueta: "5",
              ),
              MiBoton(
                fCallBack: (String sEtiqueta) => _actualizarPantallaCalculadora(sEtiqueta),
                sEtiqueta: "6",
              ),
              MiBoton(
                fCallBack: (String sEtiqueta) => _actualizarPantallaCalculadora(sEtiqueta),
                sEtiqueta: "-",
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MiBoton(
                        fCallBack: (String sEtiqueta) => _ejecutarFuncionEspecial(sEtiqueta),
                        sEtiqueta: "1",
                      ),
                      MiBoton(
                        fCallBack: (String sEtiqueta) => _ejecutarFuncionEspecial(sEtiqueta),
                        sEtiqueta: "2",
                      ),
                      MiBoton(
                        fCallBack: (String sEtiqueta) => _actualizarPantallaCalculadora(sEtiqueta),
                        sEtiqueta: "3",
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MiBoton(
                        fCallBack: (String sEtiqueta) => _ejecutarFuncionEspecial(sEtiqueta),
                        sEtiqueta: "0",
                      ),
                      MiBoton(
                        fCallBack: (String sEtiqueta) => _ejecutarFuncionEspecial(sEtiqueta),
                        sEtiqueta: ".",
                      ),
                      MiBoton(
                        fCallBack: (String sEtiqueta) => _actualizarPantallaCalculadora(sEtiqueta),
                        sEtiqueta: "=",
                      ),
                    ],
                  ),
                ],
              ),
              MiBoton(
                fCallBack: (String sEtiqueta) => _actualizarPantallaCalculadora(sEtiqueta),
                sEtiqueta: "+",
              ),
            ],
          )
        ],
      )
    );
  }
}
