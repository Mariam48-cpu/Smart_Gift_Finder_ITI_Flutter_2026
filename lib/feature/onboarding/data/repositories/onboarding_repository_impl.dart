import 'package:injectable/injectable.dart';

import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';

@Injectable(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl(this.localDataSource);

  @override
  Future<bool> isOnboardingCompleted() {
    return localDataSource.isOnboardingCompleted();
  }

  @override
  Future<void> completeOnboarding() {
    return localDataSource.completeOnboarding();
  }
}
