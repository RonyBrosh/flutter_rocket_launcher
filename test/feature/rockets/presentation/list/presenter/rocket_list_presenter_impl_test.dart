import 'package:fake_async/fake_async.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/rocket.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/use_case/get_rockets_use_case.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/model/rocket_list_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/presenter/rocket_list_presenter_impl.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/list/router/rocket_list_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../util/ValueNotifierSpy.dart';

class GetRocketsUseCaseMock extends Mock implements GetRocketsUseCase {}

class RocketListRouterMock extends Mock implements RocketListRouter {}

void main() {
  final GetRocketsUseCaseMock getRocketsUseCaseMock = GetRocketsUseCaseMock();
  final RocketListRouterMock rocketListRouterMock = RocketListRouterMock();
  final RocketListPresenterImpl sut = RocketListPresenterImpl(getRocketsUseCaseMock, rocketListRouterMock);

  setUp(() {
    sut.toggleFilter(false);
    sut.rocketListState.value = RocketListState.loading();
  });

  group('loadRockets', () {
    test('loadRockets SHOULD emit Loading AND Error WHEN use case fails', () {
      final ErrorType errorType = ErrorType.network();
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
      when(getRocketsUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

      fakeAsync((async) {
        sut.loadRockets();

        async.flushMicrotasks();
        valueNotifierSpy.assertOrdered([
          RocketListState.loading(),
          RocketListState.error(errorType),
        ]);
      });
    });

    test('loadRockets SHOULD emit Loading AND Content WHEN use case succeeds AND content is not empty', () {
      final List<Rocket> content = [Rocket.create()];
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
      when(getRocketsUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));

      fakeAsync((async) {
        sut.loadRockets();

        async.flushMicrotasks();
        valueNotifierSpy.assertOrdered([
          RocketListState.loading(),
          RocketListState.content(content),
        ]);
      });
    });

    test('loadRockets SHOULD call refreshRockets WHEN use case succeeds AND content is empty', () {
      final List<Rocket> content = List.empty();
      when(getRocketsUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));
      when(getRocketsUseCaseMock(isRefresh: true)).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));

      fakeAsync((async) {
        sut.loadRockets();

        async.flushMicrotasks();
        verify(getRocketsUseCaseMock(isRefresh: true));
      });
    });
  });

  group('refreshRockets', () {
    test('refreshRockets SHOULD emit empty content AND Loading AND Error WHEN use case fails', () {
      final ErrorType errorType = ErrorType.network();
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
      when(getRocketsUseCaseMock(isRefresh: true)).thenAnswer((realInvocation) => Future.value(ResultState.failure(errorType)));

      fakeAsync((async) {
        sut.refreshRockets();

        async.flushMicrotasks();
        valueNotifierSpy.assertOrdered([
          RocketListState.loading(),
          RocketListState.content(List.empty()),
          RocketListState.loading(),
          RocketListState.error(errorType),
        ]);
      });
    });

    test('refreshRockets SHOULD emit empty content AND Loading AND Content WHEN use case succeeds', () {
      final List<Rocket> content = [Rocket.create()];
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
      when(getRocketsUseCaseMock(isRefresh: true)).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));

      fakeAsync((async) {
        sut.refreshRockets();

        async.flushMicrotasks();
        valueNotifierSpy.assertOrdered([
          RocketListState.loading(),
          RocketListState.content(List.empty()),
          RocketListState.loading(),
          RocketListState.content(content),
        ]);
      });
    });
  });

  group('toggleFilter', () {
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

    test('toggleFilter SHOULD emit filtered content WHEN isFilterMode is true', () {
      final List<Rocket> content = [Rocket.create(id: "rocket 1", isActive: true), Rocket.create(id: "rocket 2", isActive: false)];
      final List<Rocket> filteredContent = [Rocket.create(id: "rocket 1", isActive: true)];
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
      when(getRocketsUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));

      fakeAsync((async) {
        sut.loadRockets();
        async.flushMicrotasks();

        sut.toggleFilter(true);

        valueNotifierSpy.assertOrdered([
          RocketListState.loading(),
          RocketListState.content(content),
          RocketListState.content(filteredContent),
        ]);
      });
    });

    test('toggleFilter SHOULD emit all content WHEN isFilterMode is false', () {
      final List<Rocket> content = [Rocket.create(id: "rocket 1", isActive: true), Rocket.create(id: "rocket 2", isActive: false)];
      final List<Rocket> filteredContent = [Rocket.create(id: "rocket 1", isActive: true)];
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketListState);
      when(getRocketsUseCaseMock()).thenAnswer((realInvocation) => Future.value(ResultState.success(content)));

      fakeAsync((async) {
        sut.loadRockets();
        async.flushMicrotasks();

        sut.toggleFilter(true);
        sut.toggleFilter(false);

        valueNotifierSpy.assertOrdered([
          RocketListState.loading(),
          RocketListState.content(content),
          RocketListState.content(filteredContent),
          RocketListState.content(content),
        ]);
      });
    });
  });

  test('onRocketClicked SHOULD navigate to rocket details WHEN clicked', () {
    final Rocket rocket = Rocket.create();

    sut.onRocketClicked(rocket);

    verify(rocketListRouterMock.goToRocketDetails(rocket));
  });
}
