import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/strings/strings.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/strings/strings_en.dart';

class SplashResources {
  BuildContext _buildContext;

  SplashResources(this._buildContext);

  SplashStrings get strings {
    Locale locale = Localizations.localeOf(_buildContext);
    switch (locale.languageCode) {
      case 'en':
        return SplashStringsEnglish();
      default:
        return SplashStringsEnglish();
    }
  }

  static SplashResources from(BuildContext buildContext) {
    return SplashResources(buildContext);
  }
}
