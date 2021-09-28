import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_title.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/rockets_assets.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/rockets_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RocketLaunchesEmptyState extends StatelessWidget {
  const RocketLaunchesEmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
            child: Padding(
          padding: const EdgeInsets.all(SPACE_BASE),
          child: TextTitle(RocketsResources.from(context).strings.noLaunchesFound),
        )),
        SvgPicture.asset(RocketsAssets.ROCKET_PLACEHOLDER)
      ],
    );
  }
}
