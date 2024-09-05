import 'package:flutter/material.dart';

class SlidingMenu extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onToggle;

  const SlidingMenu({Key? key, required this.isOpen, required this.onToggle})
      : super(key: key);

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
        color: const Color.fromARGB(255, 82, 88, 97),
        height: 200,
        width: double.infinity,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('All Items'),
              onTap: widget.onToggle,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Favorite Items'),
              onTap: widget.onToggle,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: widget.onToggle,
            ),
          ],
        ),
      ),
    );
  }
}
