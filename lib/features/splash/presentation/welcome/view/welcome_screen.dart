import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/core/presentation/dimens/space.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/presenter/welcome_screen_presenter.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/widgets/welcome_actions_widget.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/widgets/welcome_message_body_widget.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/welcome/widgets/welcome_title_widget.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeScreenPresenter _welcomeScreenPresenter;

  WelcomeScreen(this._welcomeScreenPresenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            children: [
              WelcomeTitleWidget(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(SPACE_BASE),
                    child: WelcomeMessageBodyWidget(),
                  ),
                ),
              ),
              WelcomeActionsWidget(
                onToggleWelcomeMessageClicked: _welcomeScreenPresenter.setIsWelcomeMessageEnabled,
                onNextClicked: _welcomeScreenPresenter.onNextClicked,
                onUrlClicked: _welcomeScreenPresenter.onGithubLinkClicked,
              ),
            ],
          )),
    );
  }
}
