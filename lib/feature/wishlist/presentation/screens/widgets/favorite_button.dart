import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:smart_gift_finder/feature/auth/presentation/screens/login_screen.dart';
import 'package:smart_gift_finder/feature/product_details/presentation/view/screens/product_details_screen.dart';
import 'package:smart_gift_finder/feature/wishlist/presentation/screens/wishlist_screen.dart'
    as wish;

abstract class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';

  static const String home = '/home';
  static const String categories = '/categories';
  static const String search = '/search';

  static const String aiGiftFinder = '/ai_gift_finder';
  static const String aiRecommendations = '/ai_recommendations';

  static const String productDetails = '/product_details';
  static const String cart = '/cart';
  static const String wishlist = '/wishlist';

  static const String checkout = '/checkout';
  static const String orders = '/orders';
  static const String orderDetails = '/order_details';

  static const String profile = '/profile';
  static const String editProfile = '/edit_profile';
  static const String settings = '/settings';
  static const String notificationSettings = '/notification_settings';
}

abstract class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Splash Screen'),
            ),
          ),
        );

      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Onboarding Screen'),
            ),
          ),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Register Screen'),
            ),
          ),
        );

      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Forgot Password Screen'),
            ),
          ),
        );

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Home Screen'),
            ),
          ),
        );

      case Routes.categories:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Category & Filters Screen'),
            ),
          ),
        );

      case Routes.search:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Search Screen'),
            ),
          ),
        );

      case Routes.aiGiftFinder:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('AI Gift Finder Form Screen'),
            ),
          ),
        );

      case Routes.aiRecommendations:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('AI Recommendations Results Screen'),
            ),
          ),
        );

      case Routes.productDetails:
        return MaterialPageRoute(
          builder: (_) => const ProductDetailsScreen(),
        );

      case Routes.cart:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Your Cart Screen'),
            ),
          ),
        );

      case Routes.wishlist:
        final userId = settings.arguments as String? ??
            FirebaseAuth.instance.currentUser?.uid ??
            'test_user_id';

        return MaterialPageRoute(
          builder: (context) => wish.WishlistScreen(
            userId: userId,
          ),
        );

      case Routes.checkout:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Checkout Screen'),
            ),
          ),
        );

      case Routes.orders:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Orders Screen'),
            ),
          ),
        );

      case Routes.orderDetails:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Order Details Screen'),
            ),
          ),
        );

      case Routes.profile:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Account / Profile Screen'),
            ),
          ),
        );

      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Edit Profile Screen'),
            ),
          ),
        );

      case Routes.settings:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Settings Screen'),
            ),
          ),
        );

      case Routes.notificationSettings:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Notification Settings Screen'),
            ),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No Route Defined'),
            ),
          ),
        );
    }
  }
}