// lib/features/ai_finder/data/datasources/ai_gift_data_source.dart

import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';

import '../models/ai_gift_request_dto.dart';
import '../models/ai_gift_response_dto.dart';

abstract class AIGiftDataSource {
  Future<AIGiftResponseDTO> getGiftRecommendations(
    AIGiftRequestDTO request,
  );
}

@LazySingleton(as: AIGiftDataSource)
class AIGiftDataSourceImpl implements AIGiftDataSource {
  final GenerativeModel _generativeModel;

  AIGiftDataSourceImpl(this._generativeModel);

  @override
  Future<AIGiftResponseDTO> getGiftRecommendations(
    AIGiftRequestDTO request,
  ) async {
    final prompt = '''
    You are an expert AI gift recommender system.
    Generate customized gift recommendations based on the following attributes:
    - Recipient Age: ${request.recipientAge}
    - Occasion: ${request.occasion}
    - Profession: ${request.profession}
    - Interests: ${request.interests.join(', ')}
    - Budget Limit: \$${request.budgetLimit}

    Respond ONLY with a valid JSON object following this format:
    {
      "gifts": [
        {
          "name": "Gift Name Here",
          "reasoning": "Clear explanation connecting the gift to their age, profession, interests, and budget.",
          "estimatedPrice": 50.0
        }
      ]
    }
    ''';

    final response = await _generativeModel.generateContent([
      Content.text(prompt),
    ]);

    final rawText = response.text;
    if (rawText == null || rawText.isEmpty) {
      throw Exception('Gemini API returned an empty response.');
    }

    // التنظيف من أي Markdown Formatting لو الموديل طبع ```json
    final cleanJson = rawText
        .replaceAll('```json', '')
        .replaceAll('```', '')
        .trim();

    final Map<String, dynamic> jsonMap = jsonDecode(cleanJson);
    return AIGiftResponseDTO.fromJson(jsonMap);
  }
}