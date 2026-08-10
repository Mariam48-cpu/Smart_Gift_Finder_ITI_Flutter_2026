import '../models/ai_gift_request_dto.dart';
import '../models/ai_gift_response_dto.dart';

abstract class AIGiftDataSource {
  Future<AIGiftResponseDTO> getGiftRecommendations(
    AIGiftRequestDTO request,
  );
}