abstract class ResetDataSourceInterface {
  Future<void> sendPasswordResetEmail(String email);
}