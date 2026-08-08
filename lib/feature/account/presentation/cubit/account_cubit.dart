import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
      final currentUserId = FirebaseAuth.instance.currentUser?.uid;

      if (currentUserId == null) {
        emit(AccountError("User not logged in"));
        return;
      }

      final result = await accountRepository.getUserData(currentUserId);

      account = result;
      emit(AccountSuccess(result));
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  XFile? selectedXFile; // 🟢 نستخدم XFile بدلاً من File
  Uint8List? selectedImageBytes; // للـ Preview على الويب

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedXFile = image;
      selectedImageBytes = await image.readAsBytes(); // بيشتغل ويب وموبايل
      emit(AccountImagePickedState()); // إعادة رسم الشاشة لرؤية المعاينة
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        selectedXFile = image;
        selectedImageBytes = await image.readAsBytes();
        emit(AccountImagePickedState());
      }
    } catch (e) {
      emit(AccountError(e.toString()));
    }
  }

  Future<void> updateProfile(AccountEntity user) async {
    emit(AccountLoading());
    try {
      String finalImageUrl = user.imageUrl;

      // 🟢 1. رفع الصورة لو فيه صورة جديدة مختارة
      if (selectedXFile != null || selectedImageBytes != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child('${user.uid}.jpg');

        if (kIsWeb) {
          final bytes =
              selectedImageBytes ?? await selectedXFile!.readAsBytes();
          await storageRef.putData(
            bytes,
            SettableMetadata(contentType: 'image/jpeg'),
          );
        } else {
          await storageRef.putFile(File(selectedXFile!.path));
        }

        // 🟢 2. جلب رابط الصورة بعد الرفع
        finalImageUrl = await storageRef.getDownloadURL();
        print("Uploaded Image URL: $finalImageUrl"); // للتأكد في الـ Console
      }

      // 🟢 3. إنشاء الكائن بالرابط الجديد
      final updatedUser = AccountEntity(
        uid: user.uid,
        name: user.name,
        email: user.email,
        phone: user.phone,
        address: user.address,
        birthday: user.birthday,
        imageUrl: finalImageUrl, // 👈 إرسال الرابط الجديد هنا
      );

      // 🟢 4. حفظ الكائن في Firestore
      await accountRepository.updateUserData(updatedUser);

      account = updatedUser;
      selectedXFile = null;
      selectedImageBytes = null;
      emit(AccountSuccess(updatedUser));
    } catch (e) {
      print("Error updating profile: $e");
      emit(AccountError(e.toString()));
    }
  }
}
