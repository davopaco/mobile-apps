import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:items_list/components/items/item_circular_button.dart';
import 'package:items_list/components/items/items_list.dart';
import 'package:items_list/components/items/sliding_menu.dart';
import 'package:items_list/model/item.dart';
import 'package:items_list/usecases/items_usecase.dart';
import 'package:items_list/usecases/login_usecase.dart';

class ItemsView extends StatefulWidget {
  final bool isFavoriteView;
  final ItemsUseCase itemsUseCase;
  final LoginUsecase loginUsecase;
  final ScrollController scrollController;

  ItemsView(
      {super.key,
      required this.isFavoriteView,
      required this.itemsUseCase,
      required this.loginUsecase})
      : scrollController = ScrollController();

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  final _menuNotifier = ValueNotifier<bool>(false);
  bool _isGridChanged = false;
  late OverlayEntry _overlayEntry;

  @override
  void dispose() {
    if (_menuNotifier.value) {
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

  void _toggleGrid() {
    setState(() {
      _isGridChanged = !_isGridChanged;
    });
  }

  void _toggleMenu() {
    _menuNotifier.value = !_menuNotifier.value;
    if (_menuNotifier.value) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Material(
          child: SlidingMenu(
            loginUsecase: widget.loginUsecase,
            isOpen: _menuNotifier.value,
            onToggle: _toggleMenu,
          ),
        ),
      ),
    );
  }

  void _showOverlay() {
    Overlay.of(context).insert(_overlayEntry);
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
            future: widget.isFavoriteView
                ? widget.itemsUseCase.getFavoriteItems()
                : widget.itemsUseCase.getItems(),
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
                        child: ValueListenableBuilder(
                            valueListenable: _menuNotifier,
                            builder: (_, context, __) {
                              return ItemsList(
                                  itemsUseCase: widget.itemsUseCase,
                                  isGridChanged: _isGridChanged,
                                  key: const PageStorageKey('items_list'),
                                  items: snapshot.data!,
                                  scrollController: widget.scrollController);
                            })),
                  ],
                );
              }
            },
          ),
          ValueListenableBuilder(
              valueListenable: _menuNotifier,
              builder: (_, context, __) {
                return Positioned(
                  top: _menuNotifier.value ? 245 : 50,
                  right: _menuNotifier.value
                      ? Get.mediaQuery.size.width / 2.35
                      : 40,
                  child: ItemCircularButton(
                    callback: _toggleMenu,
                    icon: Icon(_menuNotifier.value ? Icons.close : Icons.menu),
                  ),
                );
              }),
          ValueListenableBuilder(
              valueListenable: _menuNotifier,
              builder: (_, context, __) {
                return Positioned(
                    top: _menuNotifier.value ? -100 : 50,
                    left: 40,
                    child: ItemCircularButton(
                      icon: const Icon(Icons.compare_arrows_rounded),
                      callback: () {
                        _toggleGrid();
                      },
                    ));
              })
        ],
      ),
    );
  }
}
