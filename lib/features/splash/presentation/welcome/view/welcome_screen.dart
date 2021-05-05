import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_assets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 200 / 56,
                child: SvgPicture.asset(SplashAssets.WELCOME_TOP_TIP),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: SPACE_SMALL, horizontal: SPACE_BASE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(),
                      child: Text(
                        SplashResources.from(context).strings.splashTitleRocket,
                        style: TextStyle(fontFamily: 'RocketLauncher', fontSize: 28, color: Colors.white),
                      ),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(),
                      child: Text(
                        SplashResources.from(context).strings.splashTitleLauncher,
                        style: TextStyle(fontFamily: 'RocketLauncher', fontSize: 28, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
