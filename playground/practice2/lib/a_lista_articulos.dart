import 'package:flutter/material.dart';
import 'package:practice2/item_articulo.dart';
import 'package:practice2/model/Item.dart';
import 'package:practice2/regresar_button.dart';

abstract class AListaArticulos extends StatefulWidget {
  abstract final Future<List<Item>> itemsList;
  abstract final String title;

  const AListaArticulos({super.key});

  @override
  State<AListaArticulos> createState() => _AListaArticulosState();
}

class _AListaArticulosState extends State<AListaArticulos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              FutureBuilder<List<Item>>(
                  future: widget.itemsList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Item>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Text('We have an error :(');
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemArticulo(item: snapshot.data![index]);
                          },
                        ),
                      );
                    }
                  }),
              const SizedBox(height: 8),
              const RegresarButton(),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }
}
