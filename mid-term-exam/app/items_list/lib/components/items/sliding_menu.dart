import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:items_list/usecases/items_usecase.dart';
import 'package:items_list/usecases/login_usecase.dart';

class SlidingMenu extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onToggle;
  final LoginUsecase loginUsecase;
  final ItemsUseCase itemsUseCase;

  const SlidingMenu(
      {super.key,
      required this.isOpen,
      required this.onToggle,
      required this.loginUsecase,
      required this.itemsUseCase});

  @override
  _SlidingMenuState createState() => _SlidingMenuState();
}

class _SlidingMenuState extends State<SlidingMenu>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _updateAnimation();
  }

  @override
  void didUpdateWidget(SlidingMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    if (widget.isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: Colors.black,
        ),
        height: 230,
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 50),
            ListTile(
                leading: const Icon(Icons.list, color: Colors.white),
                title: const Text('All Items',
                    style: TextStyle(color: Colors.white)),
                onTap: () {
                  widget.onToggle();
                  Get.toNamed("/items");
                }),
            ListTile(
              leading: const Icon(Icons.star, color: Colors.yellow),
              title: const Text('Favorite Items',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                widget.onToggle();
                Get.toNamed("/favorites");
              },
            ),
            ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title:
                    const Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  widget.onToggle();
                  await widget.loginUsecase.logout();
                  await widget.itemsUseCase.removeAllFavoriteItems();
                }),
          ],
        ),
      ),
    );
  }
}
