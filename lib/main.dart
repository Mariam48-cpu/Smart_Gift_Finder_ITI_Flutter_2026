import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/service_locator.dart';
import 'feature/auth/data/datasources/auth_remote_data_source.dart';
import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/domain/usecases/login_usecase.dart';
import 'feature/auth/domain/usecases/register_usecase.dart';
import 'feature/auth/presentation/cubit/auth_cubit.dart';
import 'feature/auth/presentation/screens/login_screen.dart';
import 'feature/onboarding/domain/repositories/onboarding_repository.dart';
import 'feature/onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import 'feature/onboarding/presentation/screens/onboarding_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Dependency Injection
  configureDependencies();

  // Initial route logic: show onboarding only on the first launch.
  final onboardingRepository = serviceLocator<OnboardingRepository>();
  final isOnboardingCompleted =
      await CheckOnboardingStatusUseCase(onboardingRepository).call();

  runApp(MyApp(showOnboarding: !isOnboardingCompleted));
}

class MyApp extends StatelessWidget {
  final bool showOnboarding;

  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        loginUseCase: LoginUseCase(
          AuthRepositoryImpl(AuthRemoteDataSource()),
        ),
        registerUseCase: RegisterUseCase(
          AuthRepositoryImpl(AuthRemoteDataSource()),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: showOnboarding ? const OnboardingScreen() : const LoginScreen(),
      ),
    );
  }
}