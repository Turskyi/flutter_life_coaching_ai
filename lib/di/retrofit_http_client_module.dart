import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/infrastructure/data_sources/remote/rest/retrofit_client/retrofit_client.dart';
import 'package:lifecoach/res/constants.dart' as constants;

@module
abstract class RetrofitHttpClientModule {
  @lazySingleton
  RetrofitClient getRetrofitHttpClient(Dio dio) {
    return RetrofitClient(dio, baseUrl: constants.baseUrl);
  }
}
