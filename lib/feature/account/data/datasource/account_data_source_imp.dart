
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'account_data_source_interface.dart';
import '../models/account_dto.dart';
import '../../domain/entities/account_entity.dart';

@Injectable(as: AccountDataSourceInterface)
class AccountRemoteDataSourceImpl implements AccountDataSourceInterface {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  AccountRemoteDataSourceImpl(this.firestore, this.firebaseAuth);

  @override
  Future<AccountEntity> getUserData(String uid) async {
    final docSnapshot = await firestore.collection('users').doc(uid).get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      throw Exception('User account data not found');
    }

    final dto = AccountDto.fromJson(docSnapshot.data()!);
    return dto.toEntity();
  }

  @override
  Future<void> updateProfile(AccountDto user) async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .set(user.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> updateUserData(AccountEntity user) async {
    await firestore.collection('users').doc(user.uid).set({
      'name': user.name,
      'phone': user.phone,
      'address': user.address,
      'birthday': user.birthday,
      'imageUrl': user.imageUrl,
    }, SetOptions(merge: true));
  }
}
