import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_gift_finder/feature/account/domain/repository/account_repository_interface.dart';
import '../../domain/entities/account_entity.dart';
import 'account_state.dart';

@injectable
class AccountCubit extends Cubit<AccountState> {
  final AccountRepositoryInterface accountRepository;

  AccountCubit(this.accountRepository) : super(AccountInitial());

  AccountEntity? account;

  File? selectedImage;

  Future<void> getUserData() async {
    emit(AccountLoading());

    try {
      final result = await accountRepository.getUserData('user_id');

      account = result;

      emit(AccountSuccess(result));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImage = File(image.path);

        emit(AccountImagePicked(selectedImage!));
      }
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        selectedImage = File(image.path);

        emit(AccountImagePicked(selectedImage!));
      }
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  Future<void> updateProfile(AccountEntity user) async {
    emit(AccountLoading());
    try {
      await accountRepository.updateUserData(user);

      emit(AccountSuccess(user));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }
}
