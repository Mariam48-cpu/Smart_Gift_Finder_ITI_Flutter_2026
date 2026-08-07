import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo/reset_data_source_interface.dart';
import '../../domain/repo/reset_repo_interface.dart';

@LazySingleton(as: ResetRepoInterface)
class ResetRepoImp implements ResetRepoInterface {
  final ResetDataSourceInterface dataSource;

  ResetRepoImp(this.dataSource);

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await dataSource.sendPasswordResetEmail(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found with this email address.');
      } else if (e.code == 'invalid-email') {
        throw Exception('The email address is badly formatted.');
      } else {
        throw Exception(e.message ?? 'An unexpected error occurred. Please try again.');
      }
    } catch (e) {
      throw Exception('Network error. Please check your connection.');
    }
  }
}