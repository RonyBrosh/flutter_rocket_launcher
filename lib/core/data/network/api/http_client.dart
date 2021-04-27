import 'package:flutter_rocket_launcher/core/data/network/model/http_error_exception.dart';
import 'package:http/http.dart';

class HttpClient {
  final String _baseUrl;
  final Client _client;

  HttpClient(this._baseUrl, this._client);

  Future<String> get(String url) async {
    final Uri uri = Uri.https(_baseUrl, url);
    final Response response = await _client.get(uri);

    if (response.statusCode == 200) {
      return Future.value(response.body);
    } else {
      throw HttpErrorException(response.statusCode);
    }
  }
}
