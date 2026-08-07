import 'dart:io';

import 'package:flutter/material.dart';

class ProfileImagePicker extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;
  final VoidCallback onTap;

  const ProfileImagePicker({
    super.key,
    this.imageUrl,
    this.imageFile,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 55,

          backgroundImage: imageFile != null
              ? FileImage(imageFile!)
              : imageUrl != null
              ? NetworkImage(imageUrl!)
              : null,

          child: imageFile == null && imageUrl == null
              ? const Icon(Icons.person, size: 50, color: Colors.grey)
              : null,
        ),

        InkWell(
          onTap: onTap,

          child: const CircleAvatar(
            radius: 18,

            backgroundColor: Colors.deepPurple,

            child: Icon(Icons.edit, color: Colors.white, size: 18),
          ),
        ),
      ],
    );
  }
}
