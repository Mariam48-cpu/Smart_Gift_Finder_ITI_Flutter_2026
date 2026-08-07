import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/core/di/service_locator.dart';
import 'package:smart_gift_finder/feature/app_section/peresentation/view/screens/app_section_screen.dart';
import 'package:smart_gift_finder/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_gift_finder/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:smart_gift_finder/feature/auth/domain/usecases/login_usecase.dart';
import 'package:smart_gift_finder/feature/auth/domain/usecases/register_usecase.dart';
import 'package:smart_gift_finder/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:smart_gift_finder/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final remoteDataSource = AuthRemoteDataSource();
  final repository = AuthRepositoryImpl(remoteDataSource);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(
        loginUseCase: LoginUseCase(repository),
        registerUseCase: RegisterUseCase(repository),
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppSectionScreen(),
      ),
    );
  }
}
