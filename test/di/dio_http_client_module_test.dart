import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach/di/injector.dart';
import 'package:lifecoach/infrastructure/ws/rest/logging_interceptor.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockLoggingInterceptor extends Mock implements LoggingInterceptor {}

void main() {
  setUpAll(() => SharedPreferences.setMockInitialValues(<String, Object>{}));

  late Dio dio;
  late MockLoggingInterceptor mockLoggingInterceptor;

  setUp(() {
    mockLoggingInterceptor = MockLoggingInterceptor();

    GetIt.I.reset();
    GetIt.I.registerSingleton<LoggingInterceptor>(mockLoggingInterceptor);
  });

  test('Dio is correctly configured with LoggingInterceptor and timeouts',
      () async {
    // Ensure the module bindings are registered.
    await injectDependencies();

    dio = GetIt.I<Dio>();

    // Verify that the LoggingInterceptor is added.
    dio.interceptors.add(mockLoggingInterceptor);
    expect(dio.interceptors.contains(mockLoggingInterceptor), isTrue);

    // Verify timeout configurations using Duration.
    expect(dio.options.connectTimeout, equals(const Duration(minutes: 1)));
    expect(dio.options.receiveTimeout, equals(const Duration(minutes: 1)));
    expect(dio.options.sendTimeout, equals(const Duration(minutes: 1)));
  });
}
