import 'package:flutter/material.dart';
import 'package:items_list/components/items/item_circular_button.dart';
import 'package:items_list/components/items/items_list.dart';
import 'package:items_list/components/items/sliding_menu.dart';
import 'package:items_list/model/item.dart';
import 'package:items_list/usecases/items_usecase.dart';

class ItemsView extends StatefulWidget {
  final String apiEndpoint;
  final ItemsUseCase itemsUseCase;
  final ScrollController scrollController;

  ItemsView({super.key, required this.apiEndpoint, required this.itemsUseCase})
      : scrollController = ScrollController();

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  bool _isMenuOpen = false;
  late OverlayEntry _overlayEntry;

  @override
  void dispose() {
    if (_isMenuOpen) {
      _removeOverlay();
    }
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _overlayEntry = _createOverlayEntry();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Material(
          child: SlidingMenu(
            isOpen: _isMenuOpen,
            onToggle: _toggleMenu,
          ),
        ),
      ),
    );
  }

  void _showOverlay() {
    Overlay.of(context)?.insert(_overlayEntry);
  }

  void _removeOverlay() {
    _overlayEntry.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<List<Item>>(
            future: widget.itemsUseCase.getItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Column(
                  children: [
                    Container(
                        height: 130, // Adds extra space at the top
                        color: Colors.transparent),
                    Expanded(
                        child: ItemsList(
                            key: const PageStorageKey('items_list'),
                            items: snapshot.data!,
                            scrollController: widget.scrollController)),
                  ],
                );
              }
            },
          ),
          Positioned(
            top: _isMenuOpen ? 245 : 50,
            right: _isMenuOpen ? MediaQuery.of(context).size.width / 2.35 : 40,
            child: ItemCircularButton(
              callback: _toggleMenu,
              icon: Icon(_isMenuOpen ? Icons.close : Icons.menu),
            ),
          ),
          Positioned(
              top: _isMenuOpen ? -100 : 50,
              left: 40,
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
