import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_title.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/model/rocket_list_state.dart';

class RocketListStateWidget extends StatefulWidget {
  final ValueNotifier _state;
  final Function() _onRefreshRockets;

  RocketListStateWidget(this._state, this._onRefreshRockets);

  @override
  State<StatefulWidget> createState() {
    return _RocketListStateWidgetState();
  }
}

class _RocketListStateWidgetState extends State<RocketListStateWidget> {
  final List<Rocket> _rockets = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    widget._state.addListener(_onRocketListStateChanged);
  }

  @override
  void dispose() {
    widget._state.removeListener(_onRocketListStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _createWidgets(),
    );
  }

  List<Widget> _createWidgets() {
    final List<Widget> widgets = List.empty(growable: true);
    widgets.add(_createContentView());
    if (widget._state.value is Loading) {
      widgets.add(_createLoadingView());
    } else if (widget._state.value is Error) {
      widgets.add(_createErrorView(widget._state.value as Error));
    }
    return widgets;
  }

  void _onRocketListStateChanged() {
    if (widget._state.value is Content) {
      _rockets.clear();
      _rockets.addAll((widget._state.value as Content).rockets);
    }
    setState(() {});
  }

  Widget _createLoadingView() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _createErrorView(Error error) {
    return Center(child: Text('Error: ${error.errorType}'));
  }

  Widget _createContentView() {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _rockets.length,
        itemBuilder: (BuildContext context, int index) {
          final Rocket rocket = _rockets[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: SPACE_BASE, vertical: SPACE_SMALL),
            child: TextTitle(rocket.name),
          );
        },
      ),
      onRefresh: () async {
        widget._onRefreshRockets();
      },
    );
  }
}
