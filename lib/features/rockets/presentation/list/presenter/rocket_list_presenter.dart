import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/model/rocket_list_state.dart';

abstract class RocketListPresenter {
  RocketListPresenter._();

  ValueNotifier<RocketListState> get rocketListState;

  void loadRockets();

  void refreshRockets();

  void toggleFilter(bool isFilterMode);

  void onRocketClicked(Rocket rocket);
}
