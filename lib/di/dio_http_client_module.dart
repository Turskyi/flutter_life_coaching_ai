import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/infrastructure/ws/rest/interceptors/logging_interceptor.dart';

@module
abstract class DioHttpClientModule {
  @preResolve
  Future<Dio> getDioHttpClient(
    LoggingInterceptor loggingInterceptor,
  ) async {
    final Dio dio = Dio()
      ..interceptors.addAll(<Interceptor>[loggingInterceptor])
      ..options.connectTimeout = const Duration(minutes: 1)
      ..options.receiveTimeout = const Duration(minutes: 1)
      ..options.sendTimeout = const Duration(minutes: 1);

    return dio;
  }
}
