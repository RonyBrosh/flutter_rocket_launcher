import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextParagraph extends StatelessWidget {
  final String _text;

  TextParagraph(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: Theme.of(context).textTheme.bodyText2,
    );
  }
}
