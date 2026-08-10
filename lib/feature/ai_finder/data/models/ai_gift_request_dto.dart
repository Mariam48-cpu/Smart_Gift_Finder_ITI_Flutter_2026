import '../../domain/entities/ai_gift_request_entity.dart';

class AIGiftRequestDTO {
  final int recipientAge;
  final String occasion;
  final String profession;
  final List<String> interests;
  final double budgetLimit;

  const AIGiftRequestDTO({
    required this.recipientAge,
    required this.occasion,
    required this.profession,
    required this.interests,
    required this.budgetLimit,
  });

  factory AIGiftRequestDTO.fromEntity(
    AIGiftRequestEntity entity,
  ) {
    return AIGiftRequestDTO(
      recipientAge: entity.recipientAge,
      occasion: entity.occasion,
      profession: entity.profession,
      interests: entity.interests,
      budgetLimit: entity.budgetLimit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipientAge': recipientAge,
      'occasion': occasion,
      'profession': profession,
      'interests': interests,
      'budgetLimit': budgetLimit,
    };
  }
}