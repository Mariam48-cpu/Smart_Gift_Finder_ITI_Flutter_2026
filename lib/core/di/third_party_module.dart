import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_gift_finder/feature/ai_finder/presentation/view/screens/ai_finder_screen.dart';

@module
abstract class ThirdPartyModule {
  @lazySingleton
  GenerativeModel get generativeModel => GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: 'AIzaSyDM4q4OoDjTDgkF51t4b0vNvvgJaLNihoQ',
        generationConfig: GenerationConfig(
          responseMimeType: 'application/json',
        ),
      );

  @lazySingleton
  PexelsService get pexelsService => PexelsService();
}
