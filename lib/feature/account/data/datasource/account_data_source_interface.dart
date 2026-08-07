import 'package:smart_gift_finder/feature/account/data/models/account_dto.dart';
import 'package:smart_gift_finder/feature/account/domain/entities/account_entity.dart';

abstract class AccountDataSourceInterface {
  Future<AccountEntity> getUserData(String uid);

  Future<void> updateProfile(AccountDto user);
}
