import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/use_case/get_launches_use_case.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/rocket_launches_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/presenter/rocket_launches_presenter.dart';

class RocketLaunchesPresenterImpl implements RocketLaunchesPresenter {
  final ValueNotifier<RocketLaunchesState> _rocketLaunchesState = ValueNotifier(RocketLaunchesState.loading());

  final GetLaunchesUseCase _getLaunchesUseCase;

  RocketLaunchesPresenterImpl(this._getLaunchesUseCase);

  @override
  ValueNotifier<RocketLaunchesState> get rocketLaunchesState => _rocketLaunchesState;

  @override
  void loadLaunches(String rocketId) {
    _rocketLaunchesState.value = RocketLaunchesState.loading();
    _getLaunchesUseCase(rocketId).then((resultState) {
      resultState.fold(success: (launches) {
        if (launches.isNotEmpty) {
          _rocketLaunchesState.value = RocketLaunchesState.content(launches);
        } else {
          refreshLaunches(rocketId);
        }
      }, failure: (error) {
        refreshLaunches(rocketId);
      });
    });
  }

  @override
  void refreshLaunches(String rocketId) {
    _rocketLaunchesState.value = RocketLaunchesState.content(List.empty());
    _rocketLaunchesState.value = RocketLaunchesState.loading();
    _getLaunchesUseCase(rocketId, isRefresh: true).then((resultState) => resultState.fold(
          success: (launches) {
            _rocketLaunchesState.value = RocketLaunchesState.content(launches);
          },
          failure: (error) {
            _rocketLaunchesState.value = RocketLaunchesState.error(error);
          },
        ));
  }
}
