import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/widgets/rocket_launch_item_widget.dart';

class RocketLaunchesContentWidget extends StatelessWidget {
  final List<Launch> _launches;

  const RocketLaunchesContentWidget(this._launches, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: _launches.length,
      itemBuilder: (context, index) {
        return RocketLaunchItemWidget(_launches[index]);
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
