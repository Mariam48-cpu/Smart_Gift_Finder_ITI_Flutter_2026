import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/di/service_locator.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase
  await Firebase.initializeApp(
  );

  // Dependency Injection
  configureDependencies();

  runApp(const MyApp());
}
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/auth/data/datasources/auth_remote_data_source.dart';
import 'firebase_options.dart';

import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/domain/usecases/login_usecase.dart';
import 'feature/auth/domain/usecases/register_usecase.dart';
import 'feature/auth/presentation/cubit/auth_cubit.dart';
import 'feature/auth/presentation/screens/login_screen.dart';
import 'package:smart_gift_finder/feature/reset_password/new_password_screen.dart';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,

      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final remoteDataSource = AuthRemoteDataSource();

  final repository = AuthRepositoryImpl(
    remoteDataSource,
  );
  runApp(
    MyApp(repository: repository),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl repository;

  const MyApp({
    super.key,
    required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        loginUseCase: LoginUseCase(repository),
        registerUseCase: RegisterUseCase(repository),
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: NewPasswordScreen(),
      // VerificationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}