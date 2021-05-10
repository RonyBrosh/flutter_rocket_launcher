import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/strings/strings.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/strings/strings_en.dart';

class RocketsResources {
  BuildContext _buildContext;

  RocketsResources(this._buildContext);

  RocketsStrings get strings {
    Locale locale = Localizations.localeOf(_buildContext);
    switch (locale.languageCode) {
      case 'en':
        return RocketsStringsEnglish();
      default:
        return RocketsStringsEnglish();
    }
  }

  static RocketsResources from(BuildContext buildContext) {
    return RocketsResources(buildContext);
  }
}
