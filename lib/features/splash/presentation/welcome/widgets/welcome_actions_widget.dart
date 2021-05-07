import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/button/primary_action_button.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_caption.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_link.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_resources.dart';

class WelcomeActionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SPACE_BASE),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: TextCaption(SplashResources.from(context).strings.welcomeEnableMessageToggleText)),
                  Switch(
                    value: true,
                    onChanged: (isSelected) {},
                  ),
                ],
              ),
            ),
            PrimaryActionButton(SplashResources.from(context).strings.welcomeNextButton, () {}),
            TextLink(SplashResources.from(context).strings.githubLinkText, () {}, isDark: true),
          ],
        ),
      ),
    );
  }
}
