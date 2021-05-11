import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

abstract class RocketListRouter {
  RocketListRouter._();

  void goToRocketDetails(Rocket rocket);
}
