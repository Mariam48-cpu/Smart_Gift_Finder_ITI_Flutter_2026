import 'package:smart_gift_finder/feature/account/domain/entities/account_entity.dart';
import 'package:smart_gift_finder/feature/account/domain/repository/account_repository_interface.dart';

class UpdateProfile {
  final AccountRepositoryInterface repository;

  UpdateProfile(this.repository);

  Future<void> call(AccountEntity user) {
    return repository.updateUserData(user);
  }
}
