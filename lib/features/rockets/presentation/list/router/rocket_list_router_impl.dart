import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/router/rocket_list_router.dart';

class RocketListRouterImpl implements RocketListRouter {
  @override
  void goToRocketDetails(Rocket rocket) {
    print("goToRocketDetails: ${rocket.name}");
  }
}
