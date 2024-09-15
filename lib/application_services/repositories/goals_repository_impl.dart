import 'package:injectable/injectable.dart';
import 'package:lifecoach/domain_services/goals_repository.dart';
import 'package:models/models.dart';

@Injectable(as: GoalsRepository)
class GoalsRepositoryImpl implements GoalsRepository {
  const GoalsRepositoryImpl(this._restClient);

  final RestClient _restClient;

  @override
  Future<List<Goal>> getGoals({required String userId, int? page}) {
    return _restClient
        .getGoals(userId, page)
        .then((Goals goalResponse) => goalResponse.goals);
  }

  @override
  Future<Goal> create(Goal goal) {
    return _restClient.createGoal(goal).then((GoalResult response) {
      return response.goal;
    });
  }

  @override
  Future<MessageResponse> delete(Goal goal) => _restClient.deleteGoal(goal);

  @override
  Future<Goal> update(Goal goal) {
    return _restClient.updateGoal(goal).then((GoalResult response) {
      return response.goal;
    });
  }
}
