import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/util/extension/list_extensions.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';

abstract class RocketListState {
  RocketListState._();

  factory RocketListState.loading() => Loading._();

  factory RocketListState.content(List<Rocket> rockets) => Content._(rockets);

  factory RocketListState.error(ErrorType errorType) => Error._(errorType);
}

class Loading extends RocketListState {
  Loading._() : super._();

  @override
  bool operator ==(other) {
    return other is Loading;
  }

  @override
  int get hashCode => 1;
}

class Content extends RocketListState {
  Content._(this.rockets) : super._();

  final List<Rocket> rockets;

  @override
  bool operator ==(other) {
    return other is Content && rockets.isEqual(other.rockets);
  }

  @override
  int get hashCode => rockets.hashCode;
}

class Error extends RocketListState {
  Error._(this.errorType) : super._();

  final ErrorType errorType;

  @override
  bool operator ==(other) {
    return other is Error;
  }

  @override
  int get hashCode => errorType.hashCode;
}
