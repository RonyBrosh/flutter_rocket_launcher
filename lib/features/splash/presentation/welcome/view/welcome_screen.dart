import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/widgets/welcome_message_body_widget.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/widgets/welcome_title_widget.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 120, bottom: SPACE_BASE, left: SPACE_BASE, right: SPACE_BASE),
                child: WelcomeMessageBodyWidget(),
              ),
            ),
            WelcomeTitleWidget(),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //
            //
            //     Expanded(
            //         child: Container(
            //           alignment: Alignment.bottomCenter,
            //           child: TextLink(SplashResources.from(context).strings.githubLinkText, () {}),
            //         )),
            //   ],
            // ),
          ],
        ));
  }
}
