import 'package:dio/dio.dart' hide Headers;
import 'package:lifecoach/infrastructure/ws/models/authentication_response/prepare_verification_response/prepare_verification_response.dart';
import 'package:lifecoach/infrastructure/ws/models/authentication_response/sign_in_response/sign_in_response.dart';
import 'package:lifecoach/infrastructure/ws/models/authentication_response/sign_up_response/sign_up_response.dart';
import 'package:lifecoach/infrastructure/ws/models/authentication_response/verification_response.dart';
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
    // This always will be of value `password`.
    @Field('strategy') String strategy,
  );

  @override
  @GET('https://clerk.turskyi.com/v1/environment?_clerk_js_version=5.14.0')
  Future<SignOutResponse> signOut();

  @override
  @POST('https://clerk.turskyi.com/v1/client/sign_ups?_clerk_js_version=5.15.0')
  Future<SignUpResponse> signUp(
    @Field('email_address') String emailAddress,
    @Field('password') String password,
    @Field('captcha_token') String captchaToken,
    // This value is always `invisible`.
    @Field('captcha_widget_type') String captchaWidgetType,
  );

  /// The [RegisterResponse.id] will be used to call
  /// https://clerk.turskyi.com/v1/client/sign_ups/[RegisterResponse.id]/prepare_verification?_clerk_js_version=5.15.0
  /// it will send a 6 digits code to the `emailAddress` from the
  /// [signUp] form.
  @override
  @POST(
    'https://clerk.turskyi.com/v1/client/sign_ups/{id}/prepare_verification?_clerk_js_version=5.15.0',
  )
  Future<PrepareVerificationResponse> prepare(
    @Path() String id,
    // This value is always `email_code`.
    String strategy,
  );

  /// This call should be called after [prepare] and it will expect the code
  /// received on `emailAddress` from the [signUp] form.
  @override
  @POST(
    'https://clerk.turskyi.com/v1/client/sign_ups/{id}/attempt_verification?_clerk_js_version=5.15.0',
  )
  Future<VerificationResponse> verify(
    @Path() String id,
    String code,
    // This value is always `email_code`.
    String strategy,
  );
}
