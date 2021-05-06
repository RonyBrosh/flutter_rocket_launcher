import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';

class TextBulletPoint extends StatelessWidget {
  final String _text;

  TextBulletPoint(this._text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SPACE_TINY),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(SPACE_TINY),
            child: CircleAvatar(
              radius: 4.0,
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
          Flexible(
            child: Text(
              _text,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
