import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_app_bar.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/rockets_resources.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/presenter/rocket_list_presenter.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/widgets/filter_widget.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/widgets/rocket_list_state_widget.dart';

class RocketListScreen extends StatefulWidget {
  final RocketListPresenter _rocketListPresenter;

  RocketListScreen(this._rocketListPresenter);

  @override
  State<RocketListScreen> createState() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return _RocketListScreenState();
  }
}

class _RocketListScreenState extends State<RocketListScreen> {
  @override
  void initState() {
    super.initState();
    widget._rocketListPresenter.loadRockets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextAppBAr(RocketsResources.from(context).strings.listTitle),
        actions: [FilterWidget(widget._rocketListPresenter.toggleFilter)],
      ),
      body: RocketListStateWidget(
        widget._rocketListPresenter.rocketListState,
        widget._rocketListPresenter.refreshRockets,
        widget._rocketListPresenter.onRocketClicked,
      ),
    );
  }
}
