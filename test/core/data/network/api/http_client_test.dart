import 'package:flutter_rocket_launcher/core/data/network/api/http_client.dart';
import 'package:flutter_rocket_launcher/core/data/network/model/http_error_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class ClientMock extends Mock implements Client {}

void main() {
  final String baseUrl = "baseUrl";
  final String requestUrl = "requestUrl";
  final Uri uri = Uri.https(baseUrl, requestUrl);
  final ClientMock clientMock = ClientMock();
  final HttpClient sut = HttpClient(baseUrl, clientMock);

  test('getRockets SHOULD throw exception WHEN api fail with exception', () {
    when(clientMock.get(uri)).thenAnswer((_) async => throw Exception());

    expect(() => sut.get(requestUrl), throwsA(isInstanceOf<Exception>()));
  });

  test('getRockets SHOULD throw http request exception WHEN api response is not success', () {
    final Response response = Response("", 400);
    when(clientMock.get(uri)).thenAnswer((realInvocation) => Future.value(response));

    expect(() => sut.get(requestUrl), throwsA(isInstanceOf<HttpErrorException>()));
  });

  test('getRockets SHOULD return list of rocket dto WHEN api succeeds', () async {
    final String body = "body";
    final Response response = Response(body, 200);
    when(clientMock.get(uri)).thenAnswer((realInvocation) => Future.value(response));

    final String result = await sut.get(requestUrl);

    expect(result, body);
  });
}
