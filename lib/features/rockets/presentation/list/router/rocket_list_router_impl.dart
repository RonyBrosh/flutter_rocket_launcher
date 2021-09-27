import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/router/rocket_list_router.dart';
import 'package:flutter_rocket_launcher/routes/features/rockets_routes.dart';

class RocketListRouterImpl implements RocketListRouter {
  final NavigatorState _navigatorState;

  RocketListRouterImpl(this._navigatorState);

  @override
  void goToRocketDetails(Rocket rocket) {
    _navigatorState.pushNamed(RocketsRoutes.LAUNCHES_SCREEN, arguments: rocket);
  }
}
