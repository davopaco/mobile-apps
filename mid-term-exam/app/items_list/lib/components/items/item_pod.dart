import 'package:flutter/material.dart';
import 'package:items_list/model/item.dart';

class ItemPod extends StatefulWidget {
  final Item item;

  const ItemPod({super.key, required this.item});

  @override
  State<ItemPod> createState() => _ItemPodState();
}

class _ItemPodState extends State<ItemPod> {
  @override
  Widget build(BuildContext context) {
    final Item item = widget.item;
    return Container(
      height: 100,
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
              image: NetworkImage("http://localhost:3000/${item.imagePath}"),
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
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                item.vendor,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                "${item.rating} / 5",
                style: const TextStyle(fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }
}
