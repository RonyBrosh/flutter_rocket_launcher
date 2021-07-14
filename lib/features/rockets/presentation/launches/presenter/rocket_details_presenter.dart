import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/rocket_launches_state.dart';

abstract class RocketLaunchesPresenter {
  RocketLaunchesPresenter._();




  ValueNotifier<RocketLaunchesState> get rocketLaunchesState;

  void loadLaunches();

  void refreshLaunches();
}
