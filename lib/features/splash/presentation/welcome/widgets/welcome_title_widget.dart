import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_assets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeTitleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 200 / 56,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(SplashAssets.WELCOME_TOP_TIP),
          Padding(
            padding: const EdgeInsets.only(left: SPACE_LARGE),
            child: Align(
              alignment: Alignment.centerLeft,
              child: DefaultTextStyle(
                style: TextStyle(),
                child: Text(
                  SplashResources.from(context).strings.welcomeTitle,
                  style: TextStyle(fontFamily: 'RocketLauncher', fontSize: 26, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
