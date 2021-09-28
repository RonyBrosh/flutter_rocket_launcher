import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/mapper/launch_to_launch_list_item_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/launch_list_item.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/widgets/rocket_launch_item_widget.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/widgets/rocket_launches_chart_widget.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/widgets/rocket_launchheader_widget.dart';

class RocketLaunchesContentWidget extends StatelessWidget {
  final List<Launch> _launches;
  final List<LaunchListItem> _data = List.empty(growable: true);
  final Mapper<List<Launch>, List<LaunchListItem>> _dataMapper = LaunchToLaunchListItemMapper();

  RocketLaunchesContentWidget(
    this._launches, {
    Key? key,
  }) : super(key: key) {
    _data.addAll(_dataMapper(_launches));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LaunchesChartWidget(launches: _launches),
        Expanded(
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _data.length,
            itemBuilder: (context, index) {
              final item = _data[index];
              if (item is LaunchListItemHeader) {
                return RocketLaunchHeader(item.year);
              } else {
                return RocketLaunchItemWidget((item as LaunchListItemItem).launch);
              }
            },
            separatorBuilder: (context, index) {
              if (_shouldAddDivider(index)) {
                return Divider(height: 1);
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }

  bool _shouldAddDivider(int index) {
    if (_data[index] is LaunchListItemHeader) {
      return false;
    }

    final nextIndex = index + 1;
    if (nextIndex < _data.length && _data[nextIndex] is LaunchListItemHeader) {
      return false;
    }

    if (index == _data.length - 1) {
      return false;
    }

    return true;
  }
}
