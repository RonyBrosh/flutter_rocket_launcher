import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';

class PrimaryActionButton extends StatelessWidget {
  final String _text;
  final void Function() _onClicked;

  PrimaryActionButton(this._text, this._onClicked);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SPACE_BASE),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(
            _text,
            style: Theme.of(context).textTheme.button.apply(color: Colors.white),
          ),
          onPressed: _onClicked,
        ),
      ),
    );
  }
}
