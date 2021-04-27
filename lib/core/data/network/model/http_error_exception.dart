class HttpErrorException implements Exception {
  final int errorCode;

  HttpErrorException(this.errorCode);
}
