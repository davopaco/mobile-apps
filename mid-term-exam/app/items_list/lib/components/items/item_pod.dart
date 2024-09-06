import 'package:flutter/material.dart';
import 'package:items_list/model/item.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

class ItemPod extends StatefulWidget {
  final Item item;
  final host = dotenv.env['HOST'] ?? 'http://192.168.0.1';
  final port = dotenv.env['PORT'] ?? '3000';

  ItemPod({super.key, required this.item});

  @override
  State<ItemPod> createState() => _ItemPodState();
}

class _ItemPodState extends State<ItemPod> {
  @override
  Widget build(BuildContext context) {
    final Item item = widget.item;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black, width: 1)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Image(
              image: NetworkImage(
                  "${widget.host}:${widget.port}/${item.imagePath}"),
              height: 80,
              width: 80,
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                item.vendor,
                style: const TextStyle(fontSize: 15),
              ),
              Text(
                "${item.rating} / 5",
                style: const TextStyle(fontSize: 15),
              )
            ],
          )
        ],
      ),
    );
  }
}
