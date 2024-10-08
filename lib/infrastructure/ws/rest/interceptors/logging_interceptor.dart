import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LoggingInterceptor extends Interceptor {
  const LoggingInterceptor();

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log('onResponse -------------------');
    log('STATUS CODE: ${response.statusCode}');
    log('DATA: ${response.data}');
    log('-----------------------------');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('onError ---------------------');
    log('ERROR: ${err.message}');
    log('BODY: ${err.response}', stackTrace: err.stackTrace);
    log('-----------------------------');
    super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('onRequest --------------------');
    log('URI: ${options.uri.toString()}');
    log('METHOD: ${options.method}');
    log('PARAMS: ${options.queryParameters.toString()}');
    log('HEADERS: ${options.headers.toString()}');
    log('BODY: ${options.data.toString()}');
    log('-----------------------------');
    super.onRequest(options, handler);
  }
}
