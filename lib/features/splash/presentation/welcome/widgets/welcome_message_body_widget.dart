import 'package:flutter/material.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_bullet_point.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_paragraph.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_title.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_resources.dart';

class WelcomeMessageBodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTitle(SplashResources.from(context).strings.welcomeShowcaseTitle),
          Padding(
            padding: const EdgeInsets.only(top: SPACE_BASE),
            child: TextParagraph(SplashResources.from(context).strings.welcomeShowcaseParagraph),
          ),
          Padding(
            padding: const EdgeInsets.only(top: SPACE_LARGE),
            child: TextTitle(SplashResources.from(context).strings.welcomeIncludingTitle),
          ),
          Padding(
            padding: const EdgeInsets.only(top: SPACE_BASE),
            child: TextBulletPoint(SplashResources.from(context).strings.welcomeIncludingCleanArchitecture),
          ),
          TextBulletPoint(SplashResources.from(context).strings.welcomeIncludingPureFlutter),
          TextBulletPoint(SplashResources.from(context).strings.welcomeIncludingNetworking),
          TextBulletPoint(SplashResources.from(context).strings.welcomeIncludingLocalStorage),
          TextBulletPoint(SplashResources.from(context).strings.welcomeIncludingAnimations),
        ],
      ),
    );
  }
}
