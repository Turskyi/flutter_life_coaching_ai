import 'package:models/models.dart';

abstract interface class GoalsRepository {
  const GoalsRepository();

  Future<List<Goal>> getGoals({required String userId, int? page});

  Future<Goal> create(Goal goal);

  Future<Goal> update(Goal goal);

  Future<MessageResponse> delete(Goal goal);
}
