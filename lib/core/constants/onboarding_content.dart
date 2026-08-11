import 'package:flutter/material.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;
}

const List<OnboardingPageData> onboardingPages = [
  OnboardingPageData(
    icon: Icons.auto_awesome,
    title: 'Smart Gift Recommendations',
    subtitle:
        'Discover unique and thoughtful gift ideas powered by AI, tailored to every personality.',
  ),
  OnboardingPageData(
    icon: Icons.psychology_outlined,
    title: 'Personalized For Everyone',
    subtitle:
        'Answer a few quick questions and get curated suggestions for any occasion and recipient.',
  ),
  OnboardingPageData(
    icon: Icons.payments_outlined,
    title: 'Match Your Budget',
    subtitle:
        'Set your budget range and instantly find the perfect gift that fits your pocket.',
  ),
];
