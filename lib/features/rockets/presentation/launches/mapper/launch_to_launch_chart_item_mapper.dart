import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/launch_chart_item.dart';

class LaunchToLaunchChartItemMapper implements Mapper<List<Launch>, List<charts.Series<LaunchChartItem, String>>> {
  LaunchToLaunchChartItemMapper();

  @override
  List<charts.Series<LaunchChartItem, String>> call(List<Launch> input) {
    final groupedByYearMap = _groupListByYear(input);
    final keys = groupedByYearMap.keys.toList(growable: false);
    keys.sort((date, otherDate) => date.compareTo(otherDate));

    final List<LaunchChartItem> data = List.empty(growable: true);
    bool isPrimaryColour = true;
    keys.forEach((year) {
      data.add(LaunchChartItem(
        year: year,
        count: groupedByYearMap[year]!.length,
        colour: charts.ColorUtil.fromDartColor((isPrimaryColour ? Colors.blue[400] : Colors.deepPurpleAccent[100])!),
      ));
      isPrimaryColour = !isPrimaryColour;
    });

    return [
      charts.Series<LaunchChartItem, String>(
        id: "Launch chart data",
        data: data,
        domainFn: (LaunchChartItem item, _) => "${item.year}",
        measureFn: (LaunchChartItem item, _) => item.count,
        colorFn: (LaunchChartItem item, _) => item.colour,
        labelAccessorFn: (LaunchChartItem item, _) => "${item.count}",
      )
    ];
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
