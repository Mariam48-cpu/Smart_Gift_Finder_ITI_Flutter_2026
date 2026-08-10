import 'package:injectable/injectable.dart';

import '../entities/ai_gift_entity.dart';
import '../entities/ai_gift_request_entity.dart';
import '../repositories/ai_gift_repository.dart';
@injectable
class GetAIGiftRecommendationsUseCase {
  final AIGiftRepository repository;

  GetAIGiftRecommendationsUseCase({
    required this.repository,
  });

  Future<List<AIGiftEntity>> call(
    AIGiftRequestEntity request,
  ) {
    return repository.getGiftRecommendations(request);
  }
}