import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lifecoach/infrastructure/data_sources/remote/rest/retrofit_client/retrofit_client.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:models/models.dart';

@module
abstract class RestClientModule {
  @lazySingleton
  RestClient getRestClient(Dio dio) {
    return RetrofitClient(dio, baseUrl: constants.baseUrl);
  }
}
