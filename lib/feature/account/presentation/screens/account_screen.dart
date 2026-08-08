import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_cubit.dart';
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_state.dart';
import 'package:smart_gift_finder/feature/account/presentation/screens/edit_profile_screen.dart';
import 'package:smart_gift_finder/feature/account/presentation/widgets/profile_image.dart';
import '../widgets/profile_info_tile.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Account"), centerTitle: true),
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AccountError) {
            return Center(child: Text(state.message));
          }

          // 🟢 جلب بيانات المستخدم الحالية من الـ Cubit
          final user = context.read<AccountCubit>().account;

          if (user == null) {
            return const Center(child: Text("No user data found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 20),

                BlocBuilder<AccountCubit, AccountState>(
                  builder: (context, state) {
                    final cubit = context.read<AccountCubit>();
                    return ProfileImagePicker(
                      imageUrl: user.imageUrl.isNotEmpty ? user.imageUrl : null,
                      imageBytes: cubit.selectedImageBytes,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditProfileScreen(),
                          ),
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 15),

                Text(
                  user.name.isNotEmpty ? user.name : "No Name",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                // 🟢 البيانات الحقيقية الديناميكية
                ProfileInfoTile(
                  title: "Full Name",
                  value: user.name.isNotEmpty ? user.name : "Not set",
                  icon: Icons.person_outline,
                ),

                ProfileInfoTile(
                  title: "Email Address",
                  value: user.email.isNotEmpty ? user.email : "Not set",
                  icon: Icons.email_outlined,
                ),

                ProfileInfoTile(
                  title: "Phone Number",
                  value: user.phone.isNotEmpty ? user.phone : "Not set",
                  icon: Icons.phone_outlined,
                ),

                ProfileInfoTile(
                  title: "Birthday",
                  value: user.birthday.isNotEmpty ? user.birthday : "Not set",
                  icon: Icons.cake_outlined,
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Profile"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
