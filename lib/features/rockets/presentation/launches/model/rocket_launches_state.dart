import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/util/extension/list_extensions.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';

abstract class RocketLaunchesState {
  RocketLaunchesState._();

  factory RocketLaunchesState.loading() => Loading._();

  factory RocketLaunchesState.content(List<Launch> launches) => Content._(launches);

  factory RocketLaunchesState.error(ErrorType errorType) => Error._(errorType);
}

class Loading extends RocketLaunchesState {
  Loading._() : super._();

  @override
  bool operator ==(other) {
    return other is Loading;
  }

  @override
  int get hashCode => 1;
}

class Content extends RocketLaunchesState {
  final List<Launch> launches;

  Content._(this.launches) : super._();

  @override
  bool operator ==(other) {
    return other is Content && launches.isEqual(other.launches);
  }

  @override
  int get hashCode => launches.hashCode;
}

class Error extends RocketLaunchesState {
  Error._(this.errorType) : super._();

  final ErrorType errorType;
}
