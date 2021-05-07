import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextCaption extends StatelessWidget {
  final String _text;

  TextCaption(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.caption,
    );
  }
}
