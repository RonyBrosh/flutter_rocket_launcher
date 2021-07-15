import 'package:fake_async/fake_async.dart';
import 'package:flutter_rocket_launcher/core/domain/model/error_type.dart';
import 'package:flutter_rocket_launcher/core/domain/model/result_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/model/launch.dart';
import 'package:flutter_rocket_launcher/features/rockets/domain/use_case/get_launches_use_case.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/model/rocket_launches_state.dart';
import 'package:flutter_rocket_launcher/features/rockets/presentation/launches/presenter/rocket_launches_presenter_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../util/ValueNotifierSpy.dart';

class LaunchListMock extends Mock implements List<Launch> {}

class GetLaunchesUseCaseMock extends Mock implements GetLaunchesUseCase {}

class ErrorTypeMock extends Mock implements ErrorType {}

void main() {
  const ROCKET_ID = "ROCKET_ID";

  final GetLaunchesUseCaseMock getLaunchesUseCaseMock = GetLaunchesUseCaseMock();
  final RocketLaunchesPresenterImpl sut = RocketLaunchesPresenterImpl(getLaunchesUseCaseMock);

  setUp(() {
    sut.rocketLaunchesState.value = RocketLaunchesState.loading();
  });

  group("loadLaunches", () {
    test("loadLaunches SHOULD emit Loading AND Content WHEN use case succeeds AND content is not empty", () {
      final List<Launch> launches = LaunchListMock();
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketLaunchesState);
      when(() => launches.isNotEmpty).thenReturn(true);
      when(() => getLaunchesUseCaseMock(ROCKET_ID)).thenAnswer((invocation) => Future.value(ResultState.success(launches)));

      fakeAsync((async) {
        sut.loadLaunches(ROCKET_ID);

        async.flushMicrotasks();
        valueNotifierSpy.assertOrdered([
          RocketLaunchesState.loading(),
          RocketLaunchesState.content(launches),
        ]);
      });
    });

    test("loadLaunches SHOULD emit Loading AND call refresh launches WHEN use case succeeds AND content is empty", () {
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketLaunchesState);
      when(() => getLaunchesUseCaseMock(ROCKET_ID)).thenAnswer((invocation) => Future.value(ResultState.success(List.empty())));
      when(() => getLaunchesUseCaseMock(ROCKET_ID, isRefresh: true)).thenAnswer((invocation) => Future.value(ResultState.success(List.empty())));

      fakeAsync((async) {
        sut.loadLaunches(ROCKET_ID);

        async.flushMicrotasks();
        valueNotifierSpy.assertAtIndex(0, RocketLaunchesState.loading());
        verify(() => getLaunchesUseCaseMock(ROCKET_ID, isRefresh: true));
      });
    });

    test("loadLaunches SHOULD emit Loading AND call refresh launches WHEN use case fails", () {
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketLaunchesState);
      when(() => getLaunchesUseCaseMock(ROCKET_ID)).thenAnswer((invocation) => Future.value(ResultState.failure(ErrorType.unknown())));
      when(() => getLaunchesUseCaseMock(ROCKET_ID, isRefresh: true)).thenAnswer((invocation) => Future.value(ResultState.success(List.empty())));

      fakeAsync((async) {
        sut.loadLaunches(ROCKET_ID);

        async.flushMicrotasks();
        valueNotifierSpy.assertAtIndex(0, RocketLaunchesState.loading());
        verify(() => getLaunchesUseCaseMock(ROCKET_ID, isRefresh: true));
      });
    });
  });

  group("refreshLaunches", () {
    test("refreshLaunches SHOULD emit empty Content AND Loading AND Content WHEN use case succeeds", () {
      final List<Launch> launches = LaunchListMock();
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketLaunchesState);

      when(() => getLaunchesUseCaseMock(ROCKET_ID, isRefresh: true)).thenAnswer((invocation) => Future.value(ResultState.success(launches)));

      fakeAsync((async) {
        sut.refreshLaunches(ROCKET_ID);

        async.flushMicrotasks();
        valueNotifierSpy.assertOrdered([
          RocketLaunchesState.loading(),
          RocketLaunchesState.content(List.empty()),
          RocketLaunchesState.loading(),
          RocketLaunchesState.content(launches),
        ]);
      });
    });

    test("refreshLaunches SHOULD emit empty Content AND Loading AND Error WHEN use case fails", () {
      final ErrorType error = ErrorTypeMock();
      final ValueNotifierSpy valueNotifierSpy = ValueNotifierSpy(sut.rocketLaunchesState);
      when(() => getLaunchesUseCaseMock(ROCKET_ID, isRefresh: true)).thenAnswer((invocation) => Future.value(ResultState.failure(error)));

      fakeAsync((async) {
        sut.refreshLaunches(ROCKET_ID);

        async.flushMicrotasks();
        valueNotifierSpy.assertOrdered([
          RocketLaunchesState.loading(),
          RocketLaunchesState.content(List.empty()),
          RocketLaunchesState.loading(),
          RocketLaunchesState.error(error),
        ]);
      });
    });
  });
}
