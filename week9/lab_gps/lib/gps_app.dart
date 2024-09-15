import 'package:flutter/material.dart';
import 'package:lab_gps/gps_helper.dart';

class GpsApp extends StatefulWidget {
  const GpsApp({super.key});

  @override
  State<GpsApp> createState() => _GpsAppState();
}

class _GpsAppState extends State<GpsApp> {
  String url = '';
  bool openUrl = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GPS App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('GPS App'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    GpsHelper.getGps().then((oPosition) {
                      setState(() {
                        url = GpsHelper.setUrl(oPosition.latitude.toString(),
                            oPosition.longitude.toString());
                        openUrl = true;
                      });
                    }).catchError((oError) {
                      setState(() {
                        url = oError.toString();
                      });
                    });
                  },
                  child: const Text('Obtener GPS'),
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Text(
                      'Este es el URL de tu ubicación: $url',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                if (openUrl)
                  ElevatedButton(
                    onPressed: () {
                      GpsHelper.openUrl(url);
                    },
                    child: const Text('Abrir URL'),
                  ),
              ],
            ),
          ),
        ));
  }
}
