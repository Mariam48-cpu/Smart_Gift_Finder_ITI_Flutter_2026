import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_gift_finder/feature/auth/domain/entities/user_entity.dart';
import 'package:smart_gift_finder/feature/auth/domain/repositories/auth_repository.dart';
import 'package:smart_gift_finder/feature/auth/domain/usecases/login_usecase.dart';
import 'package:smart_gift_finder/feature/auth/domain/usecases/register_usecase.dart';
import 'package:smart_gift_finder/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:smart_gift_finder/feature/auth/presentation/screens/login_screen.dart';
import 'package:smart_gift_finder/feature/onboarding/presentation/screens/onboarding_screen.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<UserEntity> login(
      {required String email, required String password}) async {
    return UserEntity(uid: 'uid', email: email);
  }

  @override
  Future<UserEntity> register(
      {required String name,
      required String email,
      required String password}) async {
    return UserEntity(uid: 'uid', email: email);
  }
}

Future<void> _pumpOnboarding(WidgetTester tester) async {
  await tester.pumpWidget(
    BlocProvider(
      create: (_) => AuthCubit(
        loginUseCase: LoginUseCase(_FakeAuthRepository()),
        registerUseCase: RegisterUseCase(_FakeAuthRepository()),
      ),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OnboardingScreen(),
      ),
    ),
  );
}

void main() {
  testWidgets('renders first page with Next and Skip', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await _pumpOnboarding(tester);

    expect(find.text('Smart Gift Recommendations'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
  });

  testWidgets('tapping Next advances to the next page', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await _pumpOnboarding(tester);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Personalized For Everyone'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('tapping Skip navigates to LoginScreen and saves flag',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    await _pumpOnboarding(tester);

    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('isFirstTime'), false);
  });

  testWidgets('tapping Get Started on last page navigates to LoginScreen',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    await _pumpOnboarding(tester);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Match Your Budget'), findsOneWidget);

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
  });
}