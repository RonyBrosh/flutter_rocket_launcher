import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter_rocket_launcher/core/data/network/model/http_error_exception.dart';
import 'package:http/http.dart';

class HttpClient {
  final String _baseUrl;
  final Client _client;
  final _headers = {'Content-Type': 'application/json; charset=UTF-8'};

  HttpClient(this._baseUrl, this._client);

  Future<String> get(String url) async {
    final Uri uri = Uri.https(_baseUrl, url);
    final Response response = await _client.get(uri, headers: _headers);
    _log(response);

    return _parseResponse(response);
  }

  Future<String> post({required String url, required String body}) async {
    final Uri uri = Uri.https(_baseUrl, url);
    final Response response = await _client.post(uri, headers: _headers, body: body);
    _log(response, requestBody: body);

    return _parseResponse(response);
  }

  Future<String> _parseResponse(Response response) {
    if (response.statusCode == 200) {
      return Future.value(response.body);
    } else {
      throw HttpErrorException(response.statusCode);
    }
  }

  void _log(Response response, {String requestBody = ""}) {
    if (Foundation.kDebugMode) {
      final request = response.request;
      if (request == null) {
        return;
      }

      final String uri = request.url.toString();
      String log = "HTTP REQUEST:\n[${request.method}] $uri\n";
      request.headers.forEach((key, value) {
        log += "$key : $value\n";
      });
      log += "Body: $requestBody\n";
      log += "[${response.statusCode}] ${response.body}\n";
      print("$log\n");
    }
  }
}
