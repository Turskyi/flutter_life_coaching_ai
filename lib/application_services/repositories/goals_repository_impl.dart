import 'package:injectable/injectable.dart';
import 'package:lifecoach/domain_services/goals_repository.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/goals_response/goal_response.dart';
import 'package:lifecoach/infrastructure/ws/models/responses/goals_response/goals_response.dart';
import 'package:lifecoach/infrastructure/ws/rest/retrofit_client/retrofit_client.dart';
import 'package:models/models.dart';

@Injectable(as: GoalsRepository)
class GoalsRepositoryImpl implements GoalsRepository {
  const GoalsRepositoryImpl(this._restClient);

  final RetrofitClient _restClient;

  @override
  Future<List<Goal>> getGoals({required String userId, int? page}) {
    return _restClient
        .getGoals(userId, page)
        .then((GoalsResponse goalResponse) {
      return goalResponse.goals.map((GoalResponse goalResponse) {
        return Goal(
          id: goalResponse.id,
          title: goalResponse.title,
          content: goalResponse.content,
          createdAt: goalResponse.createdAt,
          updatedAt: goalResponse.updatedAt,
        );
      }).toList();
    });
  }
}
