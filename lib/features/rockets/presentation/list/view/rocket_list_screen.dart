import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/model/rocket_list_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/presenter/rocket_list_presenter.dart';

class RocketListScreen extends StatefulWidget {
  final RocketListPresenter _rocketListPresenter;

  RocketListScreen(this._rocketListPresenter);

  @override
  _RocketListScreenState createState() => _RocketListScreenState();
}

class _RocketListScreenState extends State<RocketListScreen> {
  @override
  void initState() {
    super.initState();
    widget._rocketListPresenter.rocketListState.addListener(_onRocketListStateChanged);
    widget._rocketListPresenter.loadRockets();
  }

  @override
  void dispose() {
    widget._rocketListPresenter.rocketListState.removeListener(_onRocketListStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget._rocketListPresenter.rocketListState.value is Loading) {
      return Text('Loading');
    } else if (widget._rocketListPresenter.rocketListState.value is Content) {
      final Content content = widget._rocketListPresenter.rocketListState.value as Content;
      return Text('Content: ${content.rockets.length}');
    } else {
      final Error error = widget._rocketListPresenter.rocketListState.value as Error;
      return Text('Error: ${error.errorType}');
    }
  }

  void _onRocketListStateChanged() {
    setState(() {});
  }
}
