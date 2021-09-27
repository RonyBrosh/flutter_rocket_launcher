import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/launch_list_item.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/widgets/rocket_launch_item_widget.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/widgets/rocket_launchheader_widget.dart';

class RocketLaunchesContentWidget extends StatelessWidget {
  final List<LaunchListItem> _data = List.empty(growable: true);

  RocketLaunchesContentWidget({
    required List<Launch> launches,
    Key? key,
  }) : super(key: key) {
    prepareData(launches);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
        return Divider(height: 1);
      },
    );
  }

  void prepareData(List<Launch> launches) {
    final groupedByYearMap = Map<int, List<Launch>>();
    launches.forEach((launch) {
      if (groupedByYearMap[launch.date.year] == null) {
        groupedByYearMap[launch.date.year] = List<Launch>.empty(growable: true);
      }
      groupedByYearMap[launch.date.year]!.add(launch);
    });

    final keys = groupedByYearMap.keys.toList(growable: false);
    keys.sort((date, otherDate) => date.compareTo(otherDate));

    keys.forEach((year) {
      _data.add(LaunchListItem.header(year));
      groupedByYearMap[year]!.forEach((launch) {
        _data.add(LaunchListItem.item(launch));
      });
    });
  }
}
