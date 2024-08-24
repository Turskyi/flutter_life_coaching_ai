import 'package:dio/dio.dart' hide Headers;
import 'package:lifecoach/infrastructure/ws/models/sign_in_response/sign_in_response.dart';
import 'package:lifecoach/infrastructure/ws/models/sign_out_response/sign_out_response.dart';
import 'package:models/models.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_client.g.dart';

/// https://pub.dev/packages/retrofit
@RestApi()
abstract class RetrofitClient implements RestClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @override
  @POST('https://clerk.turskyi.com/v1/client/sign_ins?_clerk_js_version=5.14.0')
  @FormUrlEncoded()
  Future<SignInResponse> signIn(
    @Field('identifier') String identifier,
    @Field('password') String password,
    // This always will be of value "password".
    @Field('strategy') String strategy,
  );

  @override
  @GET('https://clerk.turskyi.com/v1/environment?_clerk_js_version=5.14.0')
  Future<SignOutResponse> signOut();
}
