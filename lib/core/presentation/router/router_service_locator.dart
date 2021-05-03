import 'package:flutter/widgets.dart';

class RouterServiceLocator {
  static RouterServiceLocator _instance;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  RouterServiceLocator._();

  static RouterServiceLocator getInstance() {
    if (_instance == null) {
      _instance = RouterServiceLocator._();
    }

    return _instance;
  }
}
