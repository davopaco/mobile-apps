import 'package:flutter/material.dart';

class ItemCircularButton extends StatelessWidget {
  final VoidCallback _callback;
  final Icon _icon;

  const ItemCircularButton(
      {super.key, required VoidCallback callback, required Icon icon})
      : _callback = callback,
        _icon = icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: () {
        _callback();
      },
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      child: _icon,
    );
  }
}
