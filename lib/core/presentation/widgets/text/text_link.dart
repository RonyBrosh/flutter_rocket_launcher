import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/font_size.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';

class TextLink extends StatefulWidget {
  final String _text;
  final void Function() _onUrlClicked;

  TextLink(this._text, this._onUrlClicked);

  @override
  State<StatefulWidget> createState() {
    return _TextLinkState();
  }
}

class _TextLinkState extends State<TextLink> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        togglePressedState(true);
      },
      onTapUp: (_) {
        togglePressedState(false);
      },
      onTapCancel: () {
        togglePressedState(false);
      },
      onTap: () {
        widget._onUrlClicked();
      },
      child: Padding(
        padding: const EdgeInsets.all(SPACE_LARGE),
        child: DefaultTextStyle(
          style: TextStyle(
            color: _getTextColour(),
            fontSize: FONT_SIZE_CAPTION,
          ),
          child: Text(widget._text),
        ),
      ),
    );
  }

  void togglePressedState(bool isPressed) {
    setState(() {
      _isPressed = isPressed;
    });
  }

  Color _getTextColour() {
    if (_isPressed) {
      return Colors.white70;
    } else {
      return Colors.white;
    }
  }
}
