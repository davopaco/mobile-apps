import 'package:flutter/material.dart';
import 'package:items_list/components/items/item_circular_button.dart';
import 'package:items_list/components/items/items_list.dart';
import 'package:items_list/components/items/sliding_menu.dart';
import 'package:items_list/model/item.dart';

class ItemsView extends StatefulWidget {
  final String apiEndpoint;
  final List<Item> items;

  const ItemsView({super.key, required this.apiEndpoint, required this.items});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SlidingMenu(
            isOpen: _isMenuOpen,
            onToggle: _toggleMenu,
          ),
          ItemsList(items: widget.items),
          Positioned(
            top: _isMenuOpen ? 245 : 50,
            right: _isMenuOpen ? MediaQuery.of(context).size.width / 2.35 : 16,
            child: ItemCircularButton(
              callback: _toggleMenu,
              icon: Icon(_isMenuOpen ? Icons.close : Icons.menu),
            ),
          ),
          Positioned(
              top: _isMenuOpen ? -100 : 50,
              left: 16,
              child: ItemCircularButton(
                icon: const Icon(Icons.compare_arrows_rounded),
                callback: () {
                  Navigator.pushNamed(context, '/login');
                },
              ))
        ],
      ),
    );
  }
}