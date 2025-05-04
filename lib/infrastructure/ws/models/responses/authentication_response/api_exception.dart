import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({required this.errorCode});

  final int errorCode;

  @override
  List<Object?> get props => <Object?>[errorCode];
}
