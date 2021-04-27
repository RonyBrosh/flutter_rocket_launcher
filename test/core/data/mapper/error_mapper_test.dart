import 'dart:io';

import 'package:flutter_rocket_launcher/core/data/mapper/error_mapper.dart';
import 'package:flutter_rocket_launcher/core/data/network/model/http_error_exception.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ErrorMapper sut = ErrorMapper();

  test('call SHOULD return mapped error WHEN invoked', () {
    final Map<Exception, ErrorType> tests = {
      SocketException(""): ErrorType.network(),
      HttpErrorException(400): ErrorType.client(),
      HttpErrorException(500): ErrorType.server(),
      Exception(): ErrorType.unknown()
    };

    tests.entries.forEach((nextTest) {
      final ErrorType result = sut(nextTest.key);

      expect(result, nextTest.value);
    });
  });
}
