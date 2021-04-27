import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';

abstract class ResultState<T> {
  ResultState._();

  factory ResultState.success(T data) => Success._(data);

  factory ResultState.failure(ErrorType errorType) => Failure._(errorType);
}

class Success<T> extends ResultState<T> {
  Success._(this.data) : super._();

  final T data;

  @override
  bool operator ==(other) {
    return other is Success && data == other.data;
  }

  @override
  int get hashCode => data.hashCode;

}

class Failure<T> extends ResultState<T> {
  Failure._(this.errorType) : super._();

  final ErrorType errorType;
}
