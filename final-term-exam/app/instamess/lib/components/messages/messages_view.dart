import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instamess/components/item_circular_button.dart';
import 'package:instamess/components/messages/message_list.dart';
import 'package:instamess/components/sliding_menu.dart';
import 'package:instamess/usecases/login_usecase.dart';
import 'package:instamess/usecases/message_usecase.dart';

class MessagesView extends StatefulWidget {
  final LoginUseCase loginUsecase;
  final MessageUsecase messageUsecase;

  const MessagesView(
      {super.key, required this.messageUsecase, required this.loginUsecase});

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final _menuNotifier = ValueNotifier<bool>(false);
  late OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = _createOverlayEntry();
  }

  @override
  void dispose() {
    if (_menuNotifier.value) {
      _removeOverlay();
    }
    super.dispose();
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
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry!.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 60),
                const Text(
                  'Mensajes',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: FutureBuilder(
                      future: widget.messageUsecase.getMessages(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Text('No messages found');
                        } else {
                          final messagesWithUser = snapshot.data ?? [];
                          return MessagesList(
                              messagesWithUser: messagesWithUser,
                              messageUsecase: widget.messageUsecase);
                        }
                      },
                    ),
                  ),
                )
              ],
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
