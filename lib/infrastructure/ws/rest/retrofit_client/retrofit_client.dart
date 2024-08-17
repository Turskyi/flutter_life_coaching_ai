import 'package:dio/dio.dart' hide Headers;
import 'package:lifecoach/infrastructure/ws/models/sign_in_response/sign_in_response.dart';
import 'package:lifecoach/infrastructure/ws/models/sign_out_response/sign_out_response.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_client.g.dart';

@RestApi()
abstract class RetrofitClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @POST('https://clerk.turskyi.com/v1/client/sign_ins?_clerk_js_version=5.14.0')
  @FormUrlEncoded()
  Future<SignInResponse> signIn(
    @Field('identifier') String identifier,
    @Field('password') String password,
    @Field('strategy') String strategy,
  );

  @GET('https://clerk.turskyi.com/v1/environment?_clerk_js_version=5.14.0')
  Future<SignOutResponse> signOut();
}
