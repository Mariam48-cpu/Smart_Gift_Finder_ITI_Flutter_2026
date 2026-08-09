abstract class ResetRepoInterface {
  Future<void> sendPasswordResetEmail(String email);
}