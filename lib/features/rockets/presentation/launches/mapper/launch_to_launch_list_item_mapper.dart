import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/launch_list_item.dart';

class LaunchToLaunchListItemMapper implements Mapper<List<Launch>, List<LaunchListItem>> {
  @override
  List<LaunchListItem> call(List<Launch> input) {
    final groupedByYearMap = _groupListByYear(input);
    final keys = groupedByYearMap.keys.toList(growable: false);
    keys.sort((date, otherDate) => date.compareTo(otherDate));

    final List<LaunchListItem> result = List.empty(growable: true);
    keys.forEach((year) {
      result.add(LaunchListItem.header(year));
      groupedByYearMap[year]!.forEach((launch) {
        result.add(LaunchListItem.item(launch));
      });
    });
    return result;
  }

  Map<int, List<Launch>> _groupListByYear(List<Launch> input) {
    final result = Map<int, List<Launch>>();
    input.sort((launch, otherLaunch) => launch.date.compareTo(otherLaunch.date));
    input.forEach((launch) {
      if (result[launch.date.year] == null) {
        result[launch.date.year] = List<Launch>.empty(growable: true);
      }
      result[launch.date.year]!.add(launch);
    });
    return result;
  }
}
