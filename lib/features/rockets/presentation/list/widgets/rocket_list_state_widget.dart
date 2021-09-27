import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/model/rocket_list_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/widgets/rocket_list_item_widget.dart';

class RocketListStateWidget extends StatelessWidget {
  final ValueNotifier<RocketListState> _state;
  final Function(Rocket) _onRocketClicked;

  RocketListStateWidget(this._state, this._onRocketClicked);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RocketListState>(
      valueListenable: _state,
      builder: (BuildContext context, RocketListState state, Widget? child) {
        if (state is Content) {
          return _createContentView(state.rockets);
        } else if (state is Error) {
          return _createErrorView(state.errorType);
        } else {
          return _createLoadingView();
        }
      },
    );
  }

  Widget _createContentView(List<Rocket> rockets) {
    return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: SPACE_BASE, vertical: SPACE_SMALL),
        itemCount: rockets.length,
        itemBuilder: (context, index) {
          return RocketListItemWidget(rockets[index], _onRocketClicked);
        });
  }

  Widget _createLoadingView() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _createErrorView(ErrorType errorType) {
    return Center(child: Text('Error: $errorType'));
  }
}