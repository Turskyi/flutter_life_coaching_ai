import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/env/env.dart';
import 'package:lifecoach/infrastructure/ws/rest/interceptors/logging_interceptor.dart';

@module
abstract class DioHttpClientModule {
  @preResolve
  Future<Dio> getDioHttpClient(
    LoggingInterceptor loggingInterceptor,
  ) async {
    final Dio dio = Dio(
      BaseOptions(
        headers: <String, String>{
          'content-type': 'application/x-www-form-urlencoded',
          'Cookie': Env.clerkCookie,
        },
      ),
    )
      ..interceptors.addAll(<Interceptor>[
        loggingInterceptor,
      ])
      ..options.connectTimeout = const Duration(minutes: 1)
      ..options.receiveTimeout = const Duration(minutes: 1)
      ..options.sendTimeout = const Duration(minutes: 1);

    return dio;
  }
}
