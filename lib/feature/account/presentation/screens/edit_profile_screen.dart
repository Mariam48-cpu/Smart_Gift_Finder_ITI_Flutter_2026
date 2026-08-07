import 'package:flutter/material.dart';
import 'package:smart_gift_finder/feature/account/presentation/widgets/profile_image.dart';
import 'package:smart_gift_finder/feature/account/presentation/widgets/profile_text_field.dart';
import 'package:smart_gift_finder/feature/account/presentation/widgets/save_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            const SizedBox(height: 20),

            ProfileImagePicker(
              imageUrl: "https://i.pravatar.cc/150",
              onTap: () {},
            ),
            const SizedBox(height: 10),

            const Text(
              "Tap to change photo",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            CustomProfileTextField(
              title: "Full Name",
              hintText: "Sarah Mitchell",
              icon: Icons.person_outline,
            ),

            CustomProfileTextField(
              title: "Email Address",
              hintText: "sarah.m@example.com",
              icon: Icons.email_outlined,
              enabled: false,
            ),

            CustomProfileTextField(
              title: "Phone Number",
              hintText: "+1 234 567 8900",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            CustomProfileTextField(
              title: "Birthday (Optional)",
              hintText: "mm/dd/yyyy",
              icon: Icons.cake_outlined,
            ),

            const SizedBox(height: 30),

            CustomSaveButton(onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
