import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_title.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/rockets_resources.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/mapper/launch_to_launch_chart_item_mapper.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/launch_chart_item.dart';

class LaunchesChartWidget extends StatelessWidget {
  final List<Series<LaunchChartItem, String>> _data = List.empty(growable: true);
  final Mapper<List<Launch>, List<Series<LaunchChartItem, String>>> _dataMapper = LaunchToLaunchChartItemMapper();

  LaunchesChartWidget({required List<Launch> launches, Key? key}) : super(key: key) {
    _data.addAll(_dataMapper(launches));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(SPACE_BASE),
          child: TextTitle(RocketsResources.from(context).strings.launchesPerYear),
        ),
        AspectRatio(
            aspectRatio: 3 / 2,
            child: Padding(
              padding: const EdgeInsets.only(
                left: SPACE_BASE,
                right: SPACE_BASE,
                bottom: SPACE_BASE,
              ),
              child: BarChart(
                _data,
                animate: true,
                barRendererDecorator: BarLabelDecorator<String>(labelPosition: BarLabelPosition.outside),
                domainAxis: OrdinalAxisSpec(
                  renderSpec: SmallTickRendererSpec(labelRotation: 60),
                ),
              ),
            )),
      ],
    );
  }
}