import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id);

  final String id;

  @override
  List<Object> get props => <Object>[id];

  static const User anonymous = User('');

  bool get isAnonymous => this == anonymous || id.isEmpty;

  bool get isNotAnonymous => this != anonymous && id.isNotEmpty;
}
