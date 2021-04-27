abstract class ErrorType {
  ErrorType._();

  factory ErrorType.network() => NetworkError._();

  factory ErrorType.server() => ServerError._();

  factory ErrorType.client() => ClientError._();

  factory ErrorType.unknown() => UnknownError._();
}

class NetworkError extends ErrorType {
  NetworkError._() : super._();

  @override
  bool operator ==(other) {
    return other is NetworkError;
  }

  @override
  int get hashCode => 1;
}

class ServerError extends ErrorType {
  ServerError._() : super._();

  @override
  bool operator ==(other) {
    return other is ServerError;
  }

  @override
  int get hashCode => 2;
}

class ClientError extends ErrorType {
  ClientError._() : super._();

  @override
  bool operator ==(other) {
    return other is ClientError;
  }

  @override
  int get hashCode => 3;
}

class UnknownError extends ErrorType {
  UnknownError._() : super._();

  @override
  bool operator ==(other) {
    return other is UnknownError;
  }

  @override
  int get hashCode => 4;
}
