import 'package:models/models.dart';

abstract interface class RestClient {
  const RestClient();

  Future<LoginResponse> signEmail(String identifier);

  Future<LoginResponse> signIn(
    String identifier,
    String password,
    String strategy,
  );

  Future<GoalResult> createGoal(Goal goal);

  Future<GoalResult> updateGoal(Goal goal);

  Future<MessageResponse> deleteGoal(Goal goal);

  Future<Goals> getGoals(String userId, int? page);

  Future<MessageResponse> deleteAccount(String userId);
}
