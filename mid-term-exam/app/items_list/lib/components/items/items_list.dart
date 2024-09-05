import 'package:flutter/material.dart';
import 'package:items_list/components/items/item_pod.dart';
import 'package:items_list/model/item.dart';

class ItemsList extends StatefulWidget {
  final List<Item> items;
  const ItemsList({super.key, required this.items});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: const EdgeInsets.all(18),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemPod(item: items[index]);
      },
    );
  }
}
