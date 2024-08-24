import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/infrastructure/ws/rest/logging_interceptor.dart';

@module
abstract class DioHttpClientModule {
  @lazySingleton
  Dio getDioHttpClient(
    LoggingInterceptor loggingInterceptor,
  ) {
    final Dio dio = Dio()
      ..interceptors.add(loggingInterceptor)
      ..options.connectTimeout = const Duration(minutes: 1)
      ..options.receiveTimeout = const Duration(minutes: 1)
      ..options.sendTimeout = const Duration(minutes: 1);

    return dio;
  }
}
