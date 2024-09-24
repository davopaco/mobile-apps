import 'package:flutter/material.dart';
import 'package:quiz2/item_articulo.dart';
import 'package:quiz2/model/item.dart';
import 'package:quiz2/regresar_button.dart';

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
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<Item>>(
                future: widget.itemsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ItemArticulo(item: snapshot.data![index]);
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const RegresarButton()
            ],
          ),
        ),
      ),
    );
  }
}
