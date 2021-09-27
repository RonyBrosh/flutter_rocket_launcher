import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';

class RocketLaunchHeader extends StatelessWidget {
  final int _year;

  const RocketLaunchHeader(this._year, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SPACE_SMALL),
      color: Theme.of(context).primaryColor,
      child: Text(
        "$_year",
        style: TextStyle(color: Colors.white, fontSize: Theme.of(context).textTheme.headline6?.fontSize),
      ),
    );
  }
}
