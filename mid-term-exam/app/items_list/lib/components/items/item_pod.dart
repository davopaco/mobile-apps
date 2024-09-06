import 'package:flutter/material.dart';
import 'package:items_list/model/item.dart';
import "package:flutter_dotenv/flutter_dotenv.dart";

class ItemPod extends StatefulWidget {
  final Item item;
  final bool isGridChanged;
  final host = dotenv.env['HOST'] ?? 'http://192.168.0.1';
  final port = dotenv.env['PORT'] ?? '3000';

  ItemPod({super.key, required this.item, required this.isGridChanged});

  @override
  State<ItemPod> createState() => _ItemPodState();
}

class _ItemPodState extends State<ItemPod> {
  List<Widget> podChildren(Item item) {
    return [
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image(
          image:
              NetworkImage("${widget.host}:${widget.port}/${item.imagePath}"),
          height: widget.isGridChanged ? 150 : 80,
          width: widget.isGridChanged ? 150 : 80,
        ),
      ),
      SizedBox(
        height: widget.isGridChanged ? 9 : 0,
        width: widget.isGridChanged ? 0 : 18,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: const TextStyle(fontSize: 15),
            softWrap: true,
            overflow: TextOverflow.clip,
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
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final Item item = widget.item;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.black, width: 1)),
      child: Stack(
        children: [
          widget.isGridChanged
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: podChildren(item),
                )
              : Row(
                  children: podChildren(item),
                ),
          Positioned(
              child: InkWell(
                child: const Icon(Icons.favorite),
                onTap: () {},
                splashColor: Colors.transparent,
              ),
              bottom: 0,
              right: 0),
        ],
      ),
    );
  }
}
