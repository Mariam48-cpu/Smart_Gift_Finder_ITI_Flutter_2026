import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_gift_finder/feature/account/presentation/cubit/account_cubit.dart';
import 'package:smart_gift_finder/feature/account/presentation/screens/account_screen.dart';
import 'package:smart_gift_finder/feature/auth/presentation/screens/login_screen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utlis/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenUIState();
}

class _RegisterScreenUIState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Account Created Successfully!")),
          );

          // 🟢 يجيب بيانات المستخدم المضاف حديثاً من Firestore ويفتح شاشة الـ Account
          context.read<AccountCubit>().getUserData();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AccountScreen()),
          );
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: .center,
                  children: [
                    const SizedBox(height: 10),

                    // Back Icon Button
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const LoginScreen()),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Title & Subtitle
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Join Smart Gift Finder to discover perfect\ngifts.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textMuted,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Full Name Input Field
                    CustomTextField(
                      controller: _fullNameController,
                      hintText: "Full Name",
                      validator: Validators.validateName,
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: AppColors.border,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Email Address Input Field
                    CustomTextField(
                      controller: _emailController,
                      hintText: "Email Address",
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.border,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password Input Field
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      obscureText: _isPasswordObscure,
                      validator: Validators.validatePassword,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.border,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.border,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordObscure = !_isPasswordObscure;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password Input Field
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: _isConfirmPasswordObscure,
                      validator: (value) => Validators.validateConfirmPassword(
                        value,
                        _passwordController.text,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.border,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.border,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordObscure =
                                !_isConfirmPasswordObscure;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Create Account Button
                    CustomButton(
                      text: "Create Account",
                      icon: Icons.arrow_forward,
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().register(
                            name: _fullNameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 28),

                    // Divider
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(color: AppColors.borderTransparent),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR CONTINUE WITH',
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.border,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: AppColors.borderTransparent),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Google Sign Up Button
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBgLight.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'G ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.googleBlue,
                              ),
                            ),
                            Text(
                              'Google Sign Up',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Log in link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textMuted,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Log in here",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
