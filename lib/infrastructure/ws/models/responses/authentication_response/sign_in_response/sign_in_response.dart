import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_in_response/sign_in_error_response/sign_in_error_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_in_response/sign_in_success_response/sign_in_success_response.dart';
import 'package:models/models.dart';

part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse extends LoginResponse {
  const SignInResponse({required super.userId, required super.token});

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('errors')) {
      return SignInErrorResponse.fromJson(json);
    } else {
      return SignInSuccessResponse.fromJson(json);
    }
  }
}
