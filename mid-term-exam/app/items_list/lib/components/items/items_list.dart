import 'package:flutter/material.dart';
import 'package:items_list/components/items/item_pod.dart';
import 'package:items_list/model/item.dart';
import 'package:items_list/usecases/items_usecase.dart';

class ItemsList extends StatefulWidget {
  final List<Item> items;
  final ItemsUseCase itemsUseCase;
  final bool isFavoriteList;
  final ScrollController scrollController;
  final bool isGridChanged;
  final Function(Item) onItemRemoved;

  const ItemsList(
      {super.key,
      required this.items,
      required this.scrollController,
      required this.isGridChanged,
      required this.itemsUseCase,
      required this.onItemRemoved,
      required this.isFavoriteList});

  @override
  State<ItemsList> createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    return GridView.builder(
      controller: widget.scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.isGridChanged ? 2 : 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: widget.isGridChanged ? 0.66 : 3,
      ),
      padding: EdgeInsets.all(widget.isGridChanged ? 20 : 18),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ItemPod(
            isFavorite: widget.isFavoriteList,
            item: items[index],
            isGridChanged: widget.isGridChanged,
            itemsUseCase: widget.itemsUseCase,
            onfavoriteTapped: () {
              widget.onItemRemoved(items[index]);
            });
      },
    );
  }
}
