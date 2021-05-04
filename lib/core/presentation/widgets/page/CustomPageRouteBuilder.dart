import 'package:flutter/widgets.dart';

class CustomPageRouteBuilder extends PageRouteBuilder {
  CustomPageRouteBuilder({pageBuilder, transitionsBuilder}) : super(pageBuilder: pageBuilder, transitionsBuilder: transitionsBuilder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 1000);
}
