import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/auth/data/datasources/auth_remote_data_source.dart';
import 'firebase_options.dart';

import 'feature/auth/data/repositories/auth_repository_impl.dart';
import 'feature/auth/domain/usecases/login_usecase.dart';
import 'feature/auth/domain/usecases/register_usecase.dart';
import 'feature/auth/presentation/cubit/auth_cubit.dart';
import 'feature/auth/presentation/screens/login_screen.dart';

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
    );
  }
}