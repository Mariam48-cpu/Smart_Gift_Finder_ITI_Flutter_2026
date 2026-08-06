import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xFF7C3AED);
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color background = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFF9FAFB);
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF7C3AED),
      Color(0xFFA78BFA),
    ],
  );
}
