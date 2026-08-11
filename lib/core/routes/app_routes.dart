import 'package:flutter/material.dart';

import '../../feature/account/presentation/screens/account_screen.dart';
import '../../feature/account/presentation/screens/edit_profile_screen.dart';
import '../../feature/ai_finder/peresentation/view/screens/ai_finder_screen.dart';
import '../../feature/app_section/peresentation/view/screens/app_section_screen.dart';
import '../../feature/auth/presentation/screens/login_screen.dart';
import '../../feature/auth/presentation/screens/register_screen.dart';
import '../../feature/cart/presentation/screens/cart_screen.dart';
import '../../feature/home/presentation/view/screens/home_screen.dart';
import '../../feature/home/presentation/view/screens/products_by_category_screen.dart';
import '../../feature/onboarding/presentation/screens/onboarding_screen.dart';
import '../../feature/product_details/presentation/view/screens/product_details_screen.dart';
import '../../feature/reset_password/new_password_screen.dart';
import '../../feature/reset_password/peresentation/view/screens/reset_password_screen.dart';
import '../../feature/search/peresentation/view/screens/search_screen.dart';
import '../../feature/splash/splash_view.dart';
import '../../feature/wishlist/peresentation/view/screens/wish_list.dart';

abstract class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot_password';
  static const String verification = '/verification';
  static const String newPassword = '/new_password';

  static const String appSection = '/app_section';
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
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      case Routes.newPassword:
        return MaterialPageRoute(builder: (_) => const NewPasswordScreen());

      case Routes.appSection:
        return MaterialPageRoute(builder: (_) => const AppSectionScreen());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case Routes.categories:
        return MaterialPageRoute(
          builder: (_) => ProductsByCategoryScreen(
            categorySlug: _stringArg(
              settings.arguments,
              'categorySlug',
              fallback: 'beauty',
            ),
            categoryName: _stringArg(
              settings.arguments,
              'categoryName',
              fallback: 'Category',
            ),
          ),
        );

      case Routes.search:
        return MaterialPageRoute(builder: (_) => const SearchScreen());

      case Routes.aiGiftFinder:
        return MaterialPageRoute(builder: (_) => const AIFinderScreen());

      case Routes.aiRecommendations:
        return _placeholder('AI Recommendations Results Screen');

      case Routes.productDetails:
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(
            productId: _intArg(settings.arguments, 'productId', fallback: 1),
          ),
        );

      case Routes.cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      case Routes.wishlist:
        return MaterialPageRoute(builder: (_) => const WishListScreen());

      case Routes.checkout:
        return _placeholder('Checkout Screen');

      case Routes.orders:
        return _placeholder('Orders Screen');

      case Routes.orderDetails:
        return _placeholder('Order Details Screen');

      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const AccountScreen());

      case Routes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());

      case Routes.settings:
        return _placeholder('Settings Screen');

      case Routes.notificationSettings:
        return _placeholder('Notification Settings Screen');

      default:
        return _placeholder('No Route Defined');
    }
  }

  static int _intArg(Object? arguments, String key, {int fallback = 0}) {
    if (arguments is Map) {
      final value = arguments[key];
      if (value is int) return value;
      if (value is num) return value.toInt();
      if (value is String) return int.tryParse(value) ?? fallback;
    }
    return fallback;
  }

  static String _stringArg(Object? arguments, String key,
      {String fallback = ''}) {
    if (arguments is Map) {
      final value = arguments[key];
      if (value is String) return value;
    }
    return fallback;
  }

  static Route<dynamic> _placeholder(String title) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const Center(child: Text('Coming Soon')),
      ),
    );
  }
}
