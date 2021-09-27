import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/loadable_image.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_caption.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_title.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/rockets_assets.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/rockets_resources.dart';

class RocketLaunchItemWidget extends StatelessWidget {
  final Launch _launch;

  const RocketLaunchItemWidget(this._launch);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AspectRatio(
        aspectRatio: 1 / 1,
        child: LoadableImage(
          imageUrl: _launch.imageUrl,
          fallbackAsset: RocketsAssets.ROCKET_PLACEHOLDER,
          fit: BoxFit.contain,
        ),
      ),
      title: TextTitle(_launch.name),
      subtitle: TextCaption(
          "${_launch.isSuccessful ? RocketsResources(context).strings.launchSuccessful : RocketsResources(context).strings.launchUnSuccessful}"),
    );
  }
}
