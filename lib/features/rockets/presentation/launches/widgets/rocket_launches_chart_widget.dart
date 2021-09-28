import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_title.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/rockets_resources.dart';

class LaunchesChartWidget extends StatelessWidget {
  LaunchesChartWidget({Key? key}) : super(key: key);

  final List<Series<OrdinalSales, String>> seriesList = _createSampleData();

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
                seriesList,
                animate: true,
              ),
            )),
      ],
    );
  }

  static List<Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2017', 75),
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),

    ];

    return [
      new Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
