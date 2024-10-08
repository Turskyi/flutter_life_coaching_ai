import 'package:dio/dio.dart' hide Headers;
import 'package:lifecoach/infrastructure/ws/models/requests/chat_request/chat_request.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/prepare_verification_response/prepare_verification_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_in_response/sign_in_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_up_response/sign_up_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/verification_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/created_goal_response/created_goal_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/delete_goal_response/delete_goal_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/goals_response/goals_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/sign_out_response/sign_out_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/updated_goal_response/updated_goal_response.dart';
import 'package:models/models.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_client.g.dart';

/// https://pub.dev/packages/retrofit
@RestApi()
abstract class RetrofitClient implements RestClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @override
  @POST('https://clerk.turskyi.com/v1/client/sign_ins?_clerk_js_version=5.20.0')
  @FormUrlEncoded()
  Future<SignInResponse> signEmail(@Field('identifier') String identifier);

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

  //TODO: remove due to it is not used.
  @Deprecated('There is no replacement at this moment.')
  @override
  @POST('https://clerk.turskyi.com/v1/client/sign_ups?_clerk_js_version=5.17.0')
  @FormUrlEncoded()
  Future<SignUpResponse> signUp(
    @Field('email_address') String emailAddress,
    @Field('password') String password,
  );

  //TODO: remove due to it is not used.
  /// The [RegisterResponse.id] will be used to call
  /// `https://clerk.turskyi.com/v1/client/sign_ups/[RegisterResponse.id]/
  /// prepare_verification?_clerk_js_version=5.15.0`
  /// it will send a 6 digits code to the `emailAddress` from the
  /// [signUp] form.
  @Deprecated('There is no replacement at this moment.')
  @override
  @POST(
    'https://clerk.turskyi.com/v1/client/sign_ups/{id}/prepare_verification?'
    '_clerk_js_version=5.17.0',
  )
  @FormUrlEncoded()
  Future<PrepareVerificationResponse> prepare(
    @Path() String id,
    // This value is always `email_code`.
    @Field('strategy') String strategy,
  );

  //TODO: remove due to it is not used.
  /// This call should be called after [prepare] and it will expect the code
  /// received on `emailAddress` from the [signUp] form.
  @Deprecated('There is no replacement at this moment.')
  @override
  @POST(
    'https://clerk.turskyi.com/v1/client/sign_ups/{id}/attempt_verification?'
    '_clerk_js_version=5.15.0',
  )
  @FormUrlEncoded()
  Future<VerificationResponse> verify(
    @Path() String id,
    @Field('code') String code,
    // This value is always `email_code`.
    @Field('strategy') String strategy,
  );

  @POST('anonymous-chat-web-en')
  Stream<String> sendEnglishWebChatMessage(@Body() ChatRequest chatRequest);

  @POST('anonymous-chat-web-ua')
  Stream<String> sendUkrainianWebChatMessage(@Body() ChatRequest chatRequest);

  @POST('anonymous-chat-android-en')
  Stream<String> sendEnglishAndroidAnonymousChatMessage(
    @Body() ChatRequest chatRequest,
  );

  @POST('chat-android-en')
  Stream<String> sendEnglishAndroidChatMessage(@Body() ChatRequest chatRequest);

  @POST('chat-android-ua')
  Stream<String> sendUkrainianAndroidChatMessage(
    @Body() ChatRequest chatRequest,
  );

  @POST('anonymous-chat-android-ua')
  Stream<String> sendUkrainianAndroidAnonymousChatMessage(
    @Body() ChatRequest chatRequest,
  );

  @POST('anonymous-chat-ios-en')
  Stream<String> sendEnglishIosChatMessage(@Body() ChatRequest chatRequest);

  @POST('anonymous-chat-ios-ua')
  Stream<String> sendUkrainianIosChatMessage(@Body() ChatRequest chatRequest);

  @POST('anonymous-chat')
  Stream<String> sendChatMessageOnUnknownPlatform(
    @Body() ChatRequest chatRequest,
  );

  @override
  @GET('goals')
  Future<GoalsResponse> getGoals(
    @Query('userId') String userId,
    @Query('page') int? page,
  );

  @override
  @POST('goals')
  Future<CreatedGoalResponse> createGoal(@Body() Goal goal);

  @override
  @PUT('goals')
  Future<UpdatedGoalResponse> updateGoal(@Body() Goal goal);

  @override
  @DELETE('goals')
  Future<DeleteGoalResponse> deleteGoal(@Body() Goal goal);

  @override
  @DELETE('delete-user')
  Future<DeleteGoalResponse> deleteAccount(@Query('userId') String userId);
}
