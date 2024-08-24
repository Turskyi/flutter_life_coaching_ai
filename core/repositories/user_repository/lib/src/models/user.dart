import 'package:equatable/equatable.dart';

//FIXME: For simplicity, a user just has an id property but in practice we
// might have additional properties like firstName, lastName, avatarUrl, etc…
class User extends Equatable {
  const User(this.id);

  final String id;

  @override
  List<Object> get props => <Object>[id];

  static const User empty = User('-');
}
