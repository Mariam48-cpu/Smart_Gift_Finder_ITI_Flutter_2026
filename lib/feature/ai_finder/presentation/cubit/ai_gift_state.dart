

import 'package:smart_gift_finder/feature/ai_finder/domain/entities/ai_gift_entity.dart';

abstract class AIGiftState {}

class AIGiftInitial extends AIGiftState {}

class AIGiftLoading extends AIGiftState {}

class AIGiftEmpty extends AIGiftState {}

class AIGiftSuccess extends AIGiftState {
  final List<AIGiftEntity> gifts;
  AIGiftSuccess(this.gifts);
}

class AIGiftError extends AIGiftState {
  final String message;
  AIGiftError(this.message);
}