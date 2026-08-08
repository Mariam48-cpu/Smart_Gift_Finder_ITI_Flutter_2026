import '../repositories/onboarding_repository.dart';

class CheckOnboardingStatusUseCase {
  final OnboardingRepository repository;

  CheckOnboardingStatusUseCase(this.repository);

  Future<bool> call() => repository.isOnboardingCompleted();
}
