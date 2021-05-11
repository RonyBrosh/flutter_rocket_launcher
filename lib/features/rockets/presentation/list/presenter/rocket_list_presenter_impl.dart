import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/use_case/get_rockets_use_case.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/model/rocket_list_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/presenter/rocket_list_presenter.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/router/rocket_list_router.dart';

class RocketListPresenterImpl implements RocketListPresenter {
  final ValueNotifier<RocketListState> _rocketListState = ValueNotifier(RocketListState.loading());
  final GetRocketsUseCase _getRocketsUseCase;
  final RocketListRouter _rocketListRouter;
  final List<Rocket> _content = List.empty(growable: true);
  bool _isFilterMode = false;

  RocketListPresenterImpl(this._getRocketsUseCase, this._rocketListRouter);

  @override
  ValueNotifier<RocketListState> get rocketListState => _rocketListState;

  @override
  void loadRockets() {
    _content.clear();
    _rocketListState.value = RocketListState.loading();
    _getRocketsUseCase().then((resultState) {
      resultState.fold(
        success: (rockets) {
          if (rockets.isEmpty) {
            refreshRockets();
          } else {
            _content.addAll(rockets);
            _notifyContent();
          }
        },
        failure: (errorType) {
          _rocketListState.value = RocketListState.error(errorType);
        },
      );
    });
  }

  @override
  void refreshRockets() {
    _content.clear();
    _rocketListState.value = RocketListState.content(_content.toList());
    _rocketListState.value = RocketListState.loading();
    _getRocketsUseCase(isRefresh: true).then((resultState) {
      resultState.fold(
        success: (rockets) {
          _content.addAll(rockets);
          _notifyContent();
        },
        failure: (errorType) {
          _rocketListState.value = RocketListState.error(errorType);
        },
      );
    });
  }

  @override
  void toggleFilter(bool isFilterMode) {
    _isFilterMode = isFilterMode;

    final RocketListState currentState = _rocketListState.value;
    if (currentState is Content == false) {
      return;
    }

    _notifyContent();
  }

  @override
  void onRocketClicked(Rocket rocket) {
    _rocketListRouter.goToRocketDetails(rocket);
  }

  void _notifyContent() {
    if (_isFilterMode) {
      final List<Rocket> filteredRockets = _content.where((rocket) => rocket.isActive).toList();
      _rocketListState.value = RocketListState.content(filteredRockets);
    } else {
      _rocketListState.value = RocketListState.content(_content.toList());
    }
  }
}
