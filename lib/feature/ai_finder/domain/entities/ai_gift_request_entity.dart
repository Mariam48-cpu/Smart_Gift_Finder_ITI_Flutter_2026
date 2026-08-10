class AIGiftRequestEntity {
  final int recipientAge;
  final String occasion;
  final String profession;
  final List<String> interests;
  final double budgetLimit;

  const AIGiftRequestEntity({
    required this.recipientAge,
    required this.occasion,
    required this.profession,
    required this.interests,
    required this.budgetLimit,
  });
}