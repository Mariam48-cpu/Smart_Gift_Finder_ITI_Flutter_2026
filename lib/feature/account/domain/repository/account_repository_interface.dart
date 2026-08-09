import 'package:smart_gift_finder/feature/account/domain/entities/account_entity.dart';

abstract class AccountRepositoryInterface {
  Future<AccountEntity> getUserData(String uid);

  Future<void> updateUserData(AccountEntity user);
}
