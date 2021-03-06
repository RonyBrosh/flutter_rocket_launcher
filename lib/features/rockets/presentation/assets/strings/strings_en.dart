import 'package:flutter_rocket_launcher/features/rockets/presentation/assets/strings/strings.dart';

class RocketsStringsEnglish implements RocketsStrings {
  //region Rocket list
  @override
  String get listTitle => "Rocket Launcher";

  @override
  String get listItemEnginesCount => "Engines count: ";

  @override
  String get listItemActive => "Rocket is active";

  //endregion

  //region Rocket launches
  @override
  String get launchSuccessful => "Successful launch";

  @override
  String get launchUnSuccessful => "Launch failed...";

  @override
  String get launchesPerYear => "Launches per Year";

  @override
  String get noLaunchesFound => "No launches found...";

  @override
  String get explore => "Explore";
  //endregion
}
