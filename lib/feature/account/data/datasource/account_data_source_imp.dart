import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'account_data_source_interface.dart';
import '../models/account_dto.dart';
import '../../domain/entities/account_entity.dart';

@Injectable(as: AccountDataSourceInterface)
class AccountRemoteDataSourceImpl
    implements AccountDataSourceInterface {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  AccountRemoteDataSourceImpl(
    this.firestore,
    this.firebaseAuth,
  );

  @override
  Future<AccountEntity> getUserData( String uid) async {
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile(AccountDto user) async {
    throw UnimplementedError();
  }
}