import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('== SHOULD return true WHEN all variables are equal', () {
    final Launch launch = Launch.create(
      id: "id",
      rocketId: "rocketId",
      name: "name",
      imageUrl: "imageUrl",
      isSuccessful: true,
      date: DateTime.now(),
    );
    final Launch anotherLaunch = Launch.create(
      id: "id",
      rocketId: "rocketId",
      name: "name",
      imageUrl: "imageUrl",
      isSuccessful: true,
      date: DateTime.now(),
    );

    final bool result = launch == anotherLaunch;

    expect(result, true);
  });

  test('== SHOULD return false WHEN not all variables are not equal', () {
    final Launch launch = Launch.create();
    final List<Launch> tests = List.empty(growable: true);
    tests.add(Launch.create(id: "id"));
    tests.add(Launch.create(rocketId: "rocketId"));
    tests.add(Launch.create(name: "name"));
    tests.add(Launch.create(imageUrl: "imageUrl"));
    tests.add(Launch.create(isSuccessful: true));
    tests.add(Launch.create(date: DateTime.fromMillisecondsSinceEpoch(1000 * 1509392040)));

    tests.forEach((nextTest) {
      final bool result = launch == nextTest;

      expect(result, false);
    });
  });
}
