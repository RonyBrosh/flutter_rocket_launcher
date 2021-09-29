import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_app_bar.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/rockets_resources.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/presenter/rocket_list_presenter.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/widgets/filter_widget.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/widgets/rocket_list_state_widget.dart';

class RocketListScreen extends StatelessWidget {
  final RocketListPresenter _rocketListPresenter;

  RocketListScreen(this._rocketListPresenter) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    _rocketListPresenter.loadRockets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextAppBAr(RocketsResources.from(context).strings.listTitle),
        actions: [FilterWidget(_rocketListPresenter.toggleFilter)],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _rocketListPresenter.refreshRockets();
        },
        child: RocketListStateWidget(
          _rocketListPresenter.rocketListState,
          _rocketListPresenter.onRocketClicked,
        ),
      ),
    );
  }
}