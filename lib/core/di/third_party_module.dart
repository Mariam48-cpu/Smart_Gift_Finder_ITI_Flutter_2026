import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_gift_finder/feature/ai_finder/presentation/view/screens/ai_finder_screen.dart';

@module
abstract class ThirdPartyModule {
  @lazySingleton
  GenerativeModel get generativeModel => GenerativeModel(
        model: 'gemini-3.5-flash',
        apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
      );

  @lazySingleton
  PexelsService get pexelsService => PexelsService();
}
