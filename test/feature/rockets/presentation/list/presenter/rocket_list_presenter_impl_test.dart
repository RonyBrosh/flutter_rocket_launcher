import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/use_case/get_rockets_use_case.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/model/rocket_list_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/presenter/rocket_list_presenter_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../util/ValueNotifierSpy.dart';

class GetRocketsUseCaseMock extends Mock implements GetRocketsUseCase {}

void main() {
  final GetRocketsUseCaseMock getRocketsUseCaseMock = GetRocketsUseCaseMock();
  final RocketListPresenterImpl sut = RocketListPresenterImpl(getRocketsUseCaseMock);

  setUp(() {
    sut.rocketListState.value = RocketListState.loading();
  });

  testWidgets('loadRockets SHOULD emit Loading AND Error WHEN use case fails', (WidgetTester widgetTester) async {
    final ErrorType errorType = ErrorType.network();
    final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
    when(getRocketsUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

    sut.loadRockets();

    await widgetTester.pump(Duration(seconds: 1));
    valueNotifierSpy.assertOrdered([
      RocketListState.loading(),
      RocketListState.error(errorType),
    ]);
  });

  testWidgets('loadRockets SHOULD emit Loading AND Content WHEN use case succeeds AND content is not empty', (WidgetTester widgetTester) async {
    final List<Rocket> content = [Rocket.create()];
    final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
    when(getRocketsUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));

    sut.loadRockets();

    await widgetTester.pump(Duration(seconds: 1));
    valueNotifierSpy.assertOrdered([
      RocketListState.loading(),
      RocketListState.content(content),
    ]);
  });

  testWidgets('loadRockets SHOULD call refreshRockets WHEN use case succeeds AND content is empty', (WidgetTester widgetTester) async {
    final List<Rocket> content = List.empty();
    when(getRocketsUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));
    when(getRocketsUseCaseMock(isRefresh: true)).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));

    sut.loadRockets();

    await widgetTester.pump(Duration(seconds: 1));
    verify(getRocketsUseCaseMock(isRefresh: true));
  });

  testWidgets('refreshRockets SHOULD emit empty content AND Loading AND Error WHEN use case fails', (WidgetTester widgetTester) async {
    final ErrorType errorType = ErrorType.network();
    final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
    when(getRocketsUseCaseMock(isRefresh: true)).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

    sut.refreshRockets();

    await widgetTester.pump(Duration(seconds: 1));
    valueNotifierSpy.assertOrdered([
      RocketListState.loading(),
      RocketListState.content(List.empty()),
      RocketListState.loading(),
      RocketListState.error(errorType),
    ]);
  });

  testWidgets('refreshRockets SHOULD emit empty content AND Loading AND Content WHEN use case succeeds', (WidgetTester widgetTester) async {
    final List<Rocket> content = [Rocket.create()];
    final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
    when(getRocketsUseCaseMock(isRefresh: true)).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));

    sut.refreshRockets();

    await widgetTester.pump(Duration(seconds: 1));
    valueNotifierSpy.assertOrdered([
      RocketListState.loading(),
      RocketListState.content(List.empty()),
      RocketListState.loading(),
      RocketListState.content(content),
    ]);
  });

  test('toggleFilter SHOULD do nothing WHEN state is Error', () {
    final ErrorType errorType = ErrorType.network();
    final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
    sut.rocketListState.value = RocketListState.error(errorType);

    sut.toggleFilter(true);

    valueNotifierSpy.assertOrdered([
      RocketListState.loading(),
      RocketListState.error(errorType),
    ]);
  });

  test('toggleFilter SHOULD do nothing WHEN state is Loading', () {
    final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);

    sut.toggleFilter(true);

    valueNotifierSpy.assertOrdered([
      RocketListState.loading(),
    ]);
  });

  testWidgets('toggleFilter SHOULD emit filtered content WHEN isFilterMode is true', (WidgetTester widgetTester) async {
    final List<Rocket> content = [Rocket.create(id: "rocket 1", isActive: true), Rocket.create(id: "rocket 2", isActive: false)];
    final List<Rocket> filteredContent = [Rocket.create(id: "rocket 1", isActive: true)];
    final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
    when(getRocketsUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));
    sut.loadRockets();
    await widgetTester.pump(Duration(seconds: 1));

    sut.toggleFilter(true);

    valueNotifierSpy.assertOrdered([
      RocketListState.loading(),
      RocketListState.content(content),
      RocketListState.content(filteredContent),
    ]);
  });

  testWidgets('toggleFilter SHOULD emit all content WHEN isFilterMode is false', (WidgetTester widgetTester) async {
    final List<Rocket> content = [Rocket.create(id: "rocket 1", isActive: true), Rocket.create(id: "rocket 2", isActive: false)];
    final List<Rocket> filteredContent = [Rocket.create(id: "rocket 1", isActive: true)];
    final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
    when(getRocketsUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));
    sut.loadRockets();
    await widgetTester.pump(Duration(seconds: 1));
    sut.toggleFilter(true);

    sut.toggleFilter(false);

    valueNotifierSpy.assertOrdered([
      RocketListState.loading(),
      RocketListState.content(content),
      RocketListState.content(filteredContent),
      RocketListState.content(content),
    ]);
  });
}
