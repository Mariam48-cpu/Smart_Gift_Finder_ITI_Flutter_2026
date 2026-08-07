import 'package:smart_gift_finder/feature/reset_password/domain/repo/reset_repo_interface.dart';

class ResetPasswordUseCase {
  final ResetRepoInterface resetRepo;

  ResetPasswordUseCase(this.resetRepo);

  Future<void> invoke(String email) async=> await resetRepo.sendPasswordResetEmail(email);
}