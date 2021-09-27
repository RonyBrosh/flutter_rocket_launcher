import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_app_bar.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/rocket_launches_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/presenter/rocket_launches_presenter.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/widgets/rocket_launches_content_widget.dart';

class RocketLaunchesScreen extends StatelessWidget {
  final RocketLaunchesPresenter _presenter;
  final Rocket _rocket;

  RocketLaunchesScreen(this._presenter, this._rocket, {Key? key}) : super(key: key) {
    _presenter.loadLaunches(_rocket.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextAppBAr(_rocket.name),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _presenter.refreshLaunches(_rocket.id);
          },
          child: ValueListenableBuilder<RocketLaunchesState>(
            valueListenable: _presenter.rocketLaunchesState,
            builder: (BuildContext context, RocketLaunchesState state, Widget? child) {
              if (state is Content) {
                return RocketLaunchesContentWidget(
                  _rocket,
                  state.launches,
                );
              } else if (state is Error) {
                return Text("Error:${state.errorType}");
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
