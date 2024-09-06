import 'package:flutter/material.dart';
import 'package:items_list/components/items/item_pod.dart';
import 'package:items_list/model/item.dart';

class ItemsList extends StatefulWidget {
  final List<Item> items;
  final ScrollController scrollController;
  const ItemsList(
      {super.key, required this.items, required this.scrollController});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    return GridView.builder(
      controller: widget.scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 3,
      ),
      padding: const EdgeInsets.all(18),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemPod(item: items[index]);
      },
    );
  }
}
