
import 'package:smart_gift_finder/feature/account/domain/entities/account_entity.dart';
import 'package:smart_gift_finder/feature/account/domain/repository/account_repository_interface.dart';

class GetUserData {
  final AccountRepositoryInterface repository;

  GetUserData(this.repository);

  Future<AccountEntity> call(String uid) {
    return repository.getUserData(uid);
  }
}
