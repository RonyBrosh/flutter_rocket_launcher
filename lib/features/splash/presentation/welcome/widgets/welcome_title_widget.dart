import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_assets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 200 / 56,
          child: SvgPicture.asset(SplashAssets.WELCOME_TOP_TIP),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SPACE_SMALL, horizontal: SPACE_BASE),
          child: DefaultTextStyle(
            style: TextStyle(),
            child: Text(
              SplashResources.from(context).strings.welcomeTitle,
              style: TextStyle(fontFamily: 'RocketLauncher', fontSize: 28, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
