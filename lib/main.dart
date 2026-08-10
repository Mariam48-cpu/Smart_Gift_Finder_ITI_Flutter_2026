import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/feature/ai_finder/peresentation/view/screens/ai_finder_screen.dart';
import 'package:smart_gift_finder/firebase_options.dart';
import 'package:smart_gift_finder/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_gift_finder/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:smart_gift_finder/feature/auth/domain/usecases/login_usecase.dart';
import 'package:smart_gift_finder/feature/auth/domain/usecases/register_usecase.dart';
import 'package:smart_gift_finder/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:smart_gift_finder/feature/account/data/datasource/account_data_source_imp.dart';
import 'package:smart_gift_finder/feature/account/data/repository/account_repository_impl.dart';
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_cubit.dart';

// Imports لشاشة الـ AI Finder والـ DI
import 'package:smart_gift_finder/core/di/service_locator.dart'; // تأكدي من مسار ملف الـ DI عندك

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // تهيئة الـ Dependency Injection للـ AI Finder
  configureDependencies(); // أو setupGetIt() حسب اسم الميثود عندك في ملف DI

  final authRemoteDataSource = AuthRemoteDataSource();
  final authRepository = AuthRepositoryImpl(authRemoteDataSource);
  final accountRemoteDataSource = AccountRemoteDataSourceImpl(
    FirebaseFirestore.instance,
    FirebaseAuth.instance,
  );

  final accountRepository = AccountRepositoryImpl(accountRemoteDataSource);

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
        BlocProvider(create: (context) => AccountCubit(accountRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const AIFinderScreen(),
      ),
    );
  }
}
