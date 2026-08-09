import '../../domain/entities/ai_gift_entity.dart';

class AIGiftResponseDTO {
  final List<AIGiftDTO> gifts;

  const AIGiftResponseDTO({
    required this.gifts,
  });

  factory AIGiftResponseDTO.fromJson(Map<String, dynamic> json) {
    final giftsJson = json['gifts'] as List<dynamic>? ?? [];

    return AIGiftResponseDTO(
      gifts: giftsJson
          .map((gift) => AIGiftDTO.fromJson(gift as Map<String, dynamic>))
          .toList(),
    );
  }

  List<AIGiftEntity> toEntities() {
    return gifts.map((gift) => gift.toEntity()).toList();
  }
}

class AIGiftDTO {
  final String name;
  final String reasoning;
  final double estimatedPrice;

  const AIGiftDTO({
    required this.name,
    required this.reasoning,
    required this.estimatedPrice,
  });

  factory AIGiftDTO.fromJson(Map<String, dynamic> json) {
    return AIGiftDTO(
      name: json['name'] as String? ?? '',
      reasoning: json['reasoning'] as String? ?? '',
      estimatedPrice: (json['estimatedPrice'] as num?)?.toDouble() ?? 0.0,
    );
  }

  AIGiftEntity toEntity() {
    return AIGiftEntity(
      name: name,
      reasoning: reasoning,
      estimatedPrice: estimatedPrice,
    );
  }
}