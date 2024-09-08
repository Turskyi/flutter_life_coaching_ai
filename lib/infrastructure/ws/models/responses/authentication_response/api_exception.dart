import 'package:equatable/equatable.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/authentication_response/sign_up_error_response/sign_up_error_response.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({required this.errorCode, required this.response});

  final int errorCode;
  final SignUpErrorResponse response;

  @override
  List<Object?> get props => <Object?>[errorCode, response];

  @override
  String toString() => response.toString();
}
