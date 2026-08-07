import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repo/reset_data_source_interface.dart';

@LazySingleton(as: ResetDataSourceInterface)
class ResetDataSourceImp implements ResetDataSourceInterface {
  final FirebaseAuth firebaseAuth;

  ResetDataSourceImp(this.firebaseAuth);

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}