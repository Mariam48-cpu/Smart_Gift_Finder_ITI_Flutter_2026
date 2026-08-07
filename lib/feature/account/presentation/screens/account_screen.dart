import 'package:flutter/material.dart';
import 'package:smart_gift_finder/feature/account/presentation/widgets/profile_image.dart';
import '../widgets/profile_info_tile.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Account"), centerTitle: true),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            const SizedBox(height: 20),

            ProfileImagePicker(
              imageUrl: "https://i.pravatar.cc/150",

              onTap: () {},
            ),

            const SizedBox(height: 15),

            const Text(
              "Sarah Mitchell",

              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            ProfileInfoTile(
              title: "Full Name",

              value: "Sarah Mitchell",

              icon: Icons.person_outline,
            ),

            ProfileInfoTile(
              title: "Email Address",

              value: "sarah.mitchell@example.com",

              icon: Icons.email_outlined,
            ),

            ProfileInfoTile(
              title: "Phone Number",

              value: "+1 (555) 123-4567",

              icon: Icons.phone_outlined,
            ),

            ProfileInfoTile(
              title: "Birthday",

              value: "March 15, 1995",

              icon: Icons.cake_outlined,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton.icon(
                onPressed: () {
                  // navigate edit profile
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
      ),
    );
  }
}
