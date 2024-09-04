import 'package:control/domain/entities/network_error.dart';
import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({this.errorCode, required this.response});

  final int? errorCode;
  final NetworkError response;

  @override
  List<Object?> get props => [errorCode, response];

  @override
  String toString() => response.toString();
}
