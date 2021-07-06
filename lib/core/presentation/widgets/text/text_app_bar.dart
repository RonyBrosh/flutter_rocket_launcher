import 'package:flutter/material.dart';

class TextAppBAr extends StatelessWidget {
  final String _text;

  TextAppBAr(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.headline6?.apply(color: Colors.white),
    );
  }
}
