import '../entities/ai_gift_entity.dart';
import '../entities/ai_gift_request_entity.dart';

abstract class AIGiftRepository {
  Future<List<AIGiftEntity>> getGiftRecommendations(
    AIGiftRequestEntity request,
  );
}