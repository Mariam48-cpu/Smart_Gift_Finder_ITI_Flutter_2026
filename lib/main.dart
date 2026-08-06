import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Future.delayed(const Duration(seconds: 2));

  FlutterNativeSplash.remove();

  runApp(const SmartGiftFinderApp());
}

class SmartGiftFinderApp extends StatelessWidget {
  const SmartGiftFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Gift Finder',
      theme: AppTheme.lightTheme,
      initialRoute: Routes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
