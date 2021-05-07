import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/button/primary_action_button.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_caption.dart';
import 'package:flutter_rocket_launcher/core/presentation/widgets/text/text_link.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_resources.dart';

class WelcomeActionsWidget extends StatefulWidget {
  final void Function() _onUrlClicked;
  final void Function() _onNextClicked;
  final void Function(bool) _onToggleWelcomeMessageClicked;

  WelcomeActionsWidget({
    @required Function() onNextClicked,
    @required Function() onUrlClicked,
    @required Function(bool) onToggleWelcomeMessageClicked,
  })  : _onNextClicked = onNextClicked,
        _onUrlClicked = onUrlClicked,
        _onToggleWelcomeMessageClicked = onToggleWelcomeMessageClicked;

  @override
  _WelcomeActionsWidgetState createState() => _WelcomeActionsWidgetState();
}

class _WelcomeActionsWidgetState extends State<WelcomeActionsWidget> {
  bool _isWelcomeMessageEnabled = true;

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
                    value: _isWelcomeMessageEnabled,
                    onChanged: (isSelected) {
                      widget._onToggleWelcomeMessageClicked(isSelected);
                      setState(() {
                        _isWelcomeMessageEnabled = isSelected;
                      });
                    },
                  ),
                ],
              ),
            ),
            PrimaryActionButton(SplashResources.from(context).strings.welcomeNextButton, widget._onNextClicked),
            TextLink(SplashResources.from(context).strings.githubLinkText, widget._onUrlClicked, isDark: true),
          ],
        ),
      ),
    );
  }
}
