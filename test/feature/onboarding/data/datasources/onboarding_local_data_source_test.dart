import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_gift_finder/core/constants/constants.dart';
import 'package:smart_gift_finder/feature/onboarding/data/datasources/onboarding_local_data_source.dart';

void main() {
  group('OnboardingLocalDataSource', () {
    late OnboardingLocalDataSource dataSource;

    setUp(() {
      dataSource = OnboardingLocalDataSource();
    });

    test('isOnboardingCompleted returns false on first launch', () async {
      SharedPreferences.setMockInitialValues({});

      expect(await dataSource.isOnboardingCompleted(), isFalse);
    });

    test('isOnboardingCompleted returns true after completion', () async {
      SharedPreferences.setMockInitialValues({});

      await dataSource.completeOnboarding();

      expect(await dataSource.isOnboardingCompleted(), isTrue);
    });

    test(
      'completeOnboarding persists the flag to shared_preferences',
      () async {
        SharedPreferences.setMockInitialValues({});

        await dataSource.completeOnboarding();

        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getBool(AppConstants.onboardingFlagKey), isFalse);
      },
    );
  });
}
