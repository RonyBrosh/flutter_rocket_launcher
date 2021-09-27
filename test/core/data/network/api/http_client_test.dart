import 'package:flutter_rocket_launcher/core/data/network/api/http_client.dart';
import 'package:flutter_rocket_launcher/core/data/network/model/http_error_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class ClientMock extends Mock implements Client {}

void main() {
  final String baseUrl = "baseUrl";
  final String requestUrl = "requestUrl";
  final Uri uri = Uri.https(baseUrl, requestUrl);
  final headers = {'Content-Type': 'application/json; charset=UTF-8'};
  final ClientMock clientMock = ClientMock();
  final HttpClient sut = HttpClient(baseUrl, clientMock);

  group("get", () {
    test('get SHOULD throw exception WHEN api fail with exception', () {
      when(() => clientMock.get(uri, headers: headers)).thenAnswer((_) async => throw Exception());

      expect(() => sut.get(requestUrl), throwsA(isInstanceOf<Exception>()));
    });

    test('get SHOULD throw http request exception WHEN api response is not success', () {
      final Response response = Response("", 400);
      when(() => clientMock.get(uri, headers: headers)).thenAnswer((realInvocation) => Future.value(response));

      expect(() => sut.get(requestUrl), throwsA(isInstanceOf<HttpErrorException>()));
    });

    test('get SHOULD return list of rocket dto WHEN api succeeds', () async {
      final String body = "body";
      final Response response = Response(body, 200);
      when(() => clientMock.get(uri, headers: headers)).thenAnswer((realInvocation) => Future.value(response));

      final String result = await sut.get(requestUrl);

      expect(result, body);
    });
  });

  group("post", () {
    const BODY = "BODY";

    test('post SHOULD throw exception WHEN api fail with exception', () {
      when(() => clientMock.post(uri, headers: headers, body: BODY)).thenAnswer((_) async => throw Exception());

      expect(() => sut.post(url: requestUrl, body: BODY), throwsA(isInstanceOf<Exception>()));
    });

    test('post SHOULD throw http request exception WHEN api response is not success', () {
      final Response response = Response("", 400);
      when(() => clientMock.post(uri, headers: headers, body: BODY))
          .thenAnswer((realInvocation) => Future.value(response));

      expect(() => sut.post(url: requestUrl, body: BODY), throwsA(isInstanceOf<HttpErrorException>()));
    });

    test('post SHOULD return list of rocket dto WHEN api succeeds', () async {
      final String expected = "expected";
      final Response response = Response(expected, 200);
      when(() => clientMock.post(uri, headers: headers, body: BODY))
          .thenAnswer((realInvocation) => Future.value(response));

      final String result = await sut.post(url: requestUrl, body: BODY);

      expect(result, expected);
    });
  });
}
