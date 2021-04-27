import 'dart:io';

import 'package:flutter_rocket_launcher/core/data/network/model/http_error_exception.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/util/extension/integer_extensions.dart';
import 'package:flutter_rocket_launcher/core/util/mapper/mapper.dart';

class ErrorMapper implements Mapper<Exception, ErrorType> {
  @override
  ErrorType call(Exception input) {
    if (input is SocketException) {
      return ErrorType.network();
    }

    if (input is HttpErrorException) {
      if (input.errorCode.isInRange(start: 400, end: 499)) {
        return ErrorType.client();
      }

      if (input.errorCode.isInRange(start: 500, end: 599)) {
        return ErrorType.server();
      }
    }

    return ErrorType.unknown();
  }
}
