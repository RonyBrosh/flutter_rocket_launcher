import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/expandable_widget.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/loadable_image.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_caption.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_subtitle.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_title.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/rockets_assets.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/rockets_resources.dart';

class RocketListItemWidget extends StatelessWidget {
  final Rocket _rocket;
  final Function(Rocket) _onRocketClicked;

  RocketListItemWidget(this._rocket, this._onRocketClicked);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.only(top: SPACE_SMALL, bottom: SPACE_SMALL),
      child: ExpandableWidget(
        parent: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: _rocket.imageUrl,
              child: AspectRatio(
                  aspectRatio: 3 / 2,
                  child: LoadableImage(
                    imageUrl: _rocket.imageUrl,
                    fallbackAsset: RocketsAssets.ROCKET_PLACEHOLDER,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: SPACE_SMALL, right: SPACE_SMALL, top: SPACE_SMALL),
              child: Row(
                children: [
                  Expanded(child: TextTitle(_rocket.name)),
                  TextCaption("${_rocket.isActive ? RocketsResources(context).strings.listItemActive : ""}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: SPACE_SMALL, right: SPACE_BASE, top: SPACE_TINY),
              child: TextSubtitle(_rocket.country),
            ),
            Padding(
              padding: const EdgeInsets.all(SPACE_SMALL),
              child:
                  TextCaption("${RocketsResources.from(context).strings.listItemEnginesCount}${_rocket.enginesCount}"),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(SPACE_SMALL),
              child: TextSubtitle(_rocket.description),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: SPACE_TINY),
                child: TextButton(
                  child: Text(RocketsResources.from(context).strings.explore.toUpperCase()),
                  onPressed: () {
                    _onRocketClicked(_rocket);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
