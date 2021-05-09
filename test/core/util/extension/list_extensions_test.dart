import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rocket_launcher/core/util/extension/list_extensions.dart';

void main(){
  test('orEmpty SHOULD return empty list WHEN list is null', (){
    final List<dynamic> list = null;
    final List<dynamic> expected = [];

    final List<dynamic> result = list.orEmpty();

    expect(result, expected);
  });

  test('isEqual SHOULD return false WHEN lists are not equal', (){
    final List<int> list = [1,2,3];
    final List<int> otherList = [1,2,4];

    final bool result = list.isEqual(otherList);

    expect(result, false);
  });

  test('isEqual SHOULD return true WHEN lists are equal', (){
    final List<int> list = [1,2,3];
    final List<int> otherList = [1,2,3];

    final bool result = list.isEqual(otherList);

    expect(result, true);
  });
}
