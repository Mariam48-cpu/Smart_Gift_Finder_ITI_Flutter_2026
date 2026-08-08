import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';

@injectable
class OnboardingLocalDataSource {
  Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool(AppConstants.onboardingFlagKey) ?? true;
    return !isFirstTime;
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.onboardingFlagKey, false);
  }
}
