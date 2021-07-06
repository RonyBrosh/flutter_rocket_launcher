import 'package:flutter/widgets.dart';

class RouterServiceLocator {
  static RouterServiceLocator? _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  RouterServiceLocator._();

  static RouterServiceLocator getInstance() {
    RouterServiceLocator? instance = _instance;
    if (instance == null) {
      instance = RouterServiceLocator._();
    }
    _instance = instance;
    return instance;
  }
}
