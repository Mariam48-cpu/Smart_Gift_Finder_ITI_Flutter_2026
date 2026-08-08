import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProfileImagePicker extends StatelessWidget {
  final String? imageUrl;
  final Uint8List? imageBytes; // 🟢 دعم الـ Bytes المعاينة للويب والموبايل
  final VoidCallback onTap;

  const ProfileImagePicker({
    super.key,
    this.imageUrl,
    this.imageBytes,
    required this.onTap,
  });

  // في ملف profile_image.dart:

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    // 1. الأولوية للصورة الجديدة المختارة حالياً
    if (imageBytes != null) {
      imageProvider = MemoryImage(imageBytes!);
    }
    // 2. لو مفيش صورة جديدة، نعرض القديمة من الـ Network
    else if (imageUrl != null && imageUrl!.isNotEmpty) {
      imageProvider = NetworkImage(imageUrl!);
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: Colors.grey[200],
          backgroundImage: imageProvider,
          child: imageProvider == null
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
