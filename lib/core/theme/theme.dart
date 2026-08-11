import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle onboardingTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  static const TextStyle onboardingSubtitle = TextStyle(
    fontSize: 15,
    color: AppColors.textMuted,
    height: 1.5,
  );

  static const TextStyle skipButton = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}
