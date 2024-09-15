import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'updated_goal.dart';

part 'updated_goal_response.g.dart';

@JsonSerializable()
class UpdatedGoalResponse {
	final UpdatedGoal? updatedGoal;

	const UpdatedGoalResponse({this.updatedGoal});

	@override
	String toString() => 'UpdatedGoalResponse(updatedGoal: $updatedGoal)';

	factory UpdatedGoalResponse.fromJson(Map<String, dynamic> json) {
		return _$UpdatedGoalResponseFromJson(json);
	}

	Map<String, dynamic> toJson() => _$UpdatedGoalResponseToJson(this);

	UpdatedGoalResponse copyWith({
		UpdatedGoal? updatedGoal,
	}) {
		return UpdatedGoalResponse(
			updatedGoal: updatedGoal ?? this.updatedGoal,
		);
	}

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! UpdatedGoalResponse) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toJson(), toJson());
	}

	@override
	int get hashCode => updatedGoal.hashCode;
}
