import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/constants.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime =
        prefs.getBool(AppConstants.onboardingFlagKey) ?? true;
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;

    String route;
    if (isFirstTime) {
      route = Routes.onboarding;
    } else if (isLoggedIn) {
      route = Routes.appSection;
    } else {
      route = Routes.login;
    }

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/splash_logo.png',
              width: 140,
              height: 140,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.card_giftcard,
                size: 120,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Smart Gift Finder',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
