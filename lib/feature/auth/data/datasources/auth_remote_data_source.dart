import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user!;

    return UserModel.fromFirebase(
      uid: user.uid,
      name: user.displayName,
      email: user.email!,
    );
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await credential.user!.updateDisplayName(name);

    final user = credential.user!;

    return UserModel.fromFirebase(
      uid: user.uid,
      name: name,
      email: user.email!,
    );
  }





  User? get currentUser => _firebaseAuth.currentUser;
}