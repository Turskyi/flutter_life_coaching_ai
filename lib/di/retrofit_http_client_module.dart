import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/infrastructure/ws/rest/retrofit_client/retrofit_client.dart';
import 'package:lifecoach/res/constants.dart' as constants;

@module
abstract class RetrofitHttpClientModule {
  @lazySingleton
  RetrofitClient getRetrofitHttpClient(Dio dio) =>
      RetrofitClient(dio, baseUrl: constants.baseUrl);
}
