import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('== SHOULD return true WHEN id is equal between rockets', (){
    final Rocket rocket = Rocket.create(id: "1", name: "Rocket Name");
    final Rocket updatedRocket = Rocket.create(id: "1", name: "Updated Name");

    final bool result = rocket == updatedRocket;

    expect(result, true);
  });

  test('== SHOULD return false WHEN id is not equal between rockets', (){
    final Rocket rocket = Rocket.create(id: "1", name: "Rocket Name");
    final Rocket updatedRocket = Rocket.create(id: "2", name: "Rocket Name");

    final bool result = rocket == updatedRocket;

    expect(result, false);
  });
}
