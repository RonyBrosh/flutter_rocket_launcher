import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/opacity_widget.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_app_bar.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/rocket_launches_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/presenter/rocket_launches_presenter.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/widgets/rocket_launches_content_widget.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/widgets/rocket_launches_empty_state_widget.dart';

class RocketLaunchesScreen extends StatelessWidget {
  final RocketLaunchesPresenter _presenter;
  final Rocket _rocket;
  final scrollController = ScrollController();

  RocketLaunchesScreen(this._presenter, this._rocket, {Key? key}) : super(key: key) {
    _presenter.loadLaunches(_rocket.id);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        body: NestedScrollView(
      controller: scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverSafeArea(
              top: false,
              sliver: SliverAppBar(
                iconTheme: IconThemeData(color: Colors.white),
                pinned: true,
                expandedHeight: (screenSize.width * 2 / 3),
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      AspectRatio(aspectRatio: 3 / 2, child: Image.network(_rocket.imageUrl, fit: BoxFit.cover)),
                  title: OpacityWidget(
                    scrollController: scrollController,
                    child: TextAppBAr(_rocket.name),
                    isStartVisible: false,
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: RefreshIndicator(
        onRefresh: () async {
          _presenter.refreshLaunches(_rocket.id);
        },
        child: ValueListenableBuilder<RocketLaunchesState>(
          valueListenable: _presenter.rocketLaunchesState,
          builder: (BuildContext context, RocketLaunchesState state, Widget? child) {
            if (state is Content) {
              if (state.launches.isEmpty) {
                return RocketLaunchesEmptyState();
              } else {
                return RocketLaunchesContentWidget(state.launches);
              }
            } else if (state is Error) {
              return Text("Error:${state.errorType}");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    ));
  }
}
