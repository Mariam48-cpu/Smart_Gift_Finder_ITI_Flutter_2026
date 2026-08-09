import 'package:injectable/injectable.dart';

import '../../domain/entities/ai_gift_entity.dart';
import '../../domain/entities/ai_gift_request_entity.dart';
import '../../domain/repositories/ai_gift_repository.dart';
import '../datasources/ai_gift_data_source.dart';
import '../models/ai_gift_request_dto.dart';
@Injectable(as: AIGiftRepository)
class AIGiftRepositoryImpl implements AIGiftRepository {
  final AIGiftDataSource dataSource;

  AIGiftRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<List<AIGiftEntity>> getGiftRecommendations(
    AIGiftRequestEntity request,
  ) async {
    final requestDTO = AIGiftRequestDTO.fromEntity(request);

    final responseDTO = await dataSource.getGiftRecommendations(
      requestDTO,
    );

    return responseDTO.toEntities();
  }
}