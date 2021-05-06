import 'package:flutter_rocket_launcher/features/splash/presentation/assets/strings/strings.dart';

class SplashStringsEnglish implements SplashStrings {
  //region Shared
  @override
  String get githubLinkText => "Developed by github/RonyBrosh";

  //endregion

  //region Splash
  @override
  String get splashTitleRocket => "Rocket";

  @override
  String get splashTitleLauncher => "Launcher";

  //endregion

  //region Welcome
  @override
  String get welcomeTitle => "Rocket\nLauncher";

  @override
  String get welcomeShowcaseTitle => "Showcase App";

  @override
  String get welcomeShowcaseParagraph =>
      "Get real rocket-launching information from open source REST API.\n\nClicking a rocket item from the list will open a screen with its additional details and images.\nBoth screens can be refreshed by \"Pull to Refresh\" gesture.\n\nYou can check out this app\'s full source code in my Github account (click the link at the bottom of this screen).";

  @override
  String get welcomeIncludingTitle => "Including";

  @override
  String get welcomeIncludingCleanArchitecture => "Clean architecture principles";

  @override
  String get welcomeIncludingPureFlutter => "Pure Flutter app. Try to run it on both Android and iOS!";

  @override
  String get welcomeIncludingNetworking => "Custom error handling";

  @override
  String get welcomeIncludingLocalStorage => "Local storage support for offline mode";

  @override
  String get welcomeIncludingAnimations => "Different types of transitions and animations";

  @override
  String get welcomeEnableMessageToggleText => "Show this screen on next app launch";

  @override
  String get welcomeNextButton => "Continue";

//endregion
}
