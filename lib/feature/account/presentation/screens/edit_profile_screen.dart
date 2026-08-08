import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/feature/account/domain/entities/account_entity.dart';
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_cubit.dart';
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_state.dart';
import 'package:smart_gift_finder/feature/account/presentation/widgets/profile_image.dart';
import 'package:smart_gift_finder/feature/account/presentation/widgets/profile_text_field.dart';
import 'package:smart_gift_finder/feature/account/presentation/widgets/save_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _birthdayController;

  @override
  void initState() {
    super.initState();
    final account = context.read<AccountCubit>().account;

    _nameController = TextEditingController(text: account?.name ?? '');
    _emailController = TextEditingController(text: account?.email ?? '');
    _phoneController = TextEditingController(text: account?.phone ?? '');
    _addressController = TextEditingController(text: account?.address ?? '');
    _birthdayController = TextEditingController(text: account?.birthday ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  void _showImageSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (bottomSheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('المعرض (Gallery)'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  context.read<AccountCubit>().pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('الكاميرا (Camera)'),
                onTap: () {
                  Navigator.pop(bottomSheetContext);
                  context.read<AccountCubit>().pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true),
      body: BlocConsumer<AccountCubit, AccountState>(
        listener: (context, state) {
          if (state is AccountSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("تم تحديث الملف الشخصي بنجاح!"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is AccountError) {
            // 🟢 إظهار الخطأ المباشر لمنع تعليق زرار الـ Loading
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("حدث خطأ: ${state.message}"),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          // 🟢 مراقبة التغيرات لحظياً لإظهار الصورة فور اختيارها
          final cubit = context.watch<AccountCubit>();
          final currentAccount = cubit.account;
          final isLoading = state is AccountLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // 🟢 المعاينة اللحظية باستخدام selectedImageBytes
                ProfileImagePicker(
                  imageUrl: currentAccount?.imageUrl.isNotEmpty == true
                      ? currentAccount!.imageUrl
                      : null,
                  imageBytes: cubit.selectedImageBytes,
                  onTap: () => _showImageSourceBottomSheet(context),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Tap to change photo",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                // حقل الاسم
                CustomProfileTextField(
                  title: "Full Name",
                  hintText: "Enter your full name",
                  icon: Icons.person_outline,
                  controller: _nameController,
                ),

                // حقل البريد (معطل)
                CustomProfileTextField(
                  title: "Email Address",
                  hintText: "Email address",
                  icon: Icons.email_outlined,
                  controller: _emailController,
                  enabled: false,
                ),

                // حقل الهاتف
                CustomProfileTextField(
                  title: "Phone Number",
                  hintText: "Enter phone number",
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                ),

                // حقل العنوان
                CustomProfileTextField(
                  title: "Address",
                  hintText: "Enter your address",
                  icon: Icons.location_on_outlined,
                  controller: _addressController,
                ),

                // حقل تاريخ الميلاد
                CustomProfileTextField(
                  title: "Birthday (Optional)",
                  hintText: "DD/MM/YYYY",
                  icon: Icons.cake_outlined,
                  controller: _birthdayController,
                ),

                const SizedBox(height: 30),

                // زر الحفظ
                isLoading
                    ? const CircularProgressIndicator()
                    : CustomSaveButton(
                        onPressed: () {
                          if (currentAccount != null) {
                            final updatedUser = AccountEntity(
                              uid: currentAccount.uid,
                              name: _nameController.text.trim(),
                              email: currentAccount.email,
                              phone: _phoneController.text.trim(),
                              address: _addressController.text.trim(),
                              birthday: _birthdayController.text.trim(),
                              imageUrl: currentAccount.imageUrl,
                            );

                            cubit.updateProfile(updatedUser);
                          }
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
