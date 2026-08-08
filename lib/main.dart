import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smart_gift_finder/firebase_options.dart';

// Core
import 'package:smart_gift_finder/core/di/service_locator.dart';

// Auth
import 'package:smart_gift_finder/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_gift_finder/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:smart_gift_finder/feature/auth/domain/usecases/login_usecase.dart';
import 'package:smart_gift_finder/feature/auth/domain/usecases/register_usecase.dart';
import 'package:smart_gift_finder/feature/auth/presentation/cubit/auth_cubit.dart';

// Account
import 'package:smart_gift_finder/feature/account/data/datasource/account_data_source_imp.dart';
import 'package:smart_gift_finder/feature/account/data/repository/account_repository_impl.dart';
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_cubit.dart';

// Screens
import 'package:smart_gift_finder/feature/auth/presentation/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Auth setup
  final authRemoteDataSource = AuthRemoteDataSource();

  final authRepository = AuthRepositoryImpl(
    authRemoteDataSource,
  );

  // Account setup
  final accountRemoteDataSource = AccountRemoteDataSourceImpl(
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
  );

  final accountRepository = AccountRepositoryImpl(
    accountRemoteDataSource,
  );

  runApp(
    MyApp(
      authRepository: authRepository,
      accountRepository: accountRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final AccountRepositoryImpl accountRepository;

  const MyApp({
    super.key,
    required this.authRepository,
    required this.accountRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            loginUseCase: LoginUseCase(authRepository),
            registerUseCase: RegisterUseCase(authRepository),
          ),
        ),

        BlocProvider(
          create: (context) => AccountCubit(
            accountRepository,
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RegisterScreen(),
      ),
    );
  }
}