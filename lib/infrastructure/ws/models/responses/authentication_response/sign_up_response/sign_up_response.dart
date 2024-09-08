import 'package:json_annotation/json_annotation.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_up_error_response/sign_up_error_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_up_response/sign_up_success_response/sign_up_success_response.dart';
import 'package:models/models.dart';

part 'sign_up_response.g.dart';

@JsonSerializable()
class SignUpResponse extends RegisterResponse {
  const SignUpResponse(super.id);

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('errors')) {
      return SignUpErrorResponse.fromJson(json);
    } else {
      return SignUpSuccessResponse.fromJson(json);
    }
  }
}
