import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';

abstract class LaunchListItem {
  LaunchListItem._();

  factory LaunchListItem.header(int year) => LaunchListItemHeader._(year);

  factory LaunchListItem.item(Launch launch) => LaunchListItemItem._(launch);
}

class LaunchListItemHeader extends LaunchListItem {
  final int year;

  LaunchListItemHeader._(this.year) : super._();
}

class LaunchListItemItem extends LaunchListItem {
  final Launch launch;

  LaunchListItemItem._(this.launch) : super._();
}
