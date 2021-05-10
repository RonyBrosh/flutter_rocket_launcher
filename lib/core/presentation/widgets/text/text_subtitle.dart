import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSubtitle extends StatelessWidget {
  final String _text;

  TextSubtitle(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}
