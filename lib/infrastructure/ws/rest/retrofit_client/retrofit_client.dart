import 'package:dio/dio.dart' hide Headers;
import 'package:lifecoach/infrastructure/ws/models/requests/chat_request/chat_request.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_in_response/sign_in_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/created_goal_response/created_goal_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/delete_account_response/delete_account_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/delete_goal_response/delete_goal_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/goals_response/goals_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/updated_goal_response/updated_goal_response.dart';
import 'package:lifecoach/res/constants.dart' as constants;
import 'package:models/models.dart';
import 'package:retrofit/retrofit.dart';

part 'retrofit_client.g.dart';

/// https://pub.dev/packages/retrofit
@RestApi()
abstract class RetrofitClient implements RestClient {
  factory RetrofitClient(Dio dio, {String baseUrl}) = _RetrofitClient;

  @override
  @POST(
    'https://clerk.${constants.domain}/v1/client/sign_ins?_clerk_js_version=5.20.0',
  )
  @FormUrlEncoded()
  Future<SignInResponse> signEmail(@Field('identifier') String identifier);

  @override
  @POST(
    'https://clerk.${constants.domain}/v1/client/sign_ins?_clerk_js_version=5.14.0',
  )
  @FormUrlEncoded()
  Future<SignInResponse> signIn(
    @Field('identifier') String identifier,
    @Field('password') String password,
    // This always will be of value `password`.
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
  Stream<String> sendAnonymousEnglishIosChatMessage(
    @Body() ChatRequest chatRequest,
  );

  @POST('chat-ios-en')
  Stream<String> sendEnglishIosChatMessage(
    @Body() ChatRequest chatRequest,
  );

  @POST('anonymous-chat-ios-ua')
  Stream<String> sendAnonymousUkrainianIosChatMessage(
    @Body() ChatRequest chatRequest,
  );

  @POST('chat-ios-ua')
  Stream<String> sendUkrainianIosChatMessage(
    @Body() ChatRequest chatRequest,
  );

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
  Future<DeleteAccountResponse> deleteAccount(@Query('userId') String userId);
}
