
import 'package:smart_gift_finder/feature/account/domain/entities/account_entity.dart';

sealed class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final AccountEntity account;

  AccountSuccess(this.account);
}

class AccountError extends AccountState {
  final String message;

  AccountError(this.message);
}

class AccountImagePickedState extends AccountState {}
