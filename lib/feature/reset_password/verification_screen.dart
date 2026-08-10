import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF9F9FF), Color(0xFFEDE0FF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x147C3AED),
                          blurRadius: 20,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Color(0xFF630ED4),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x147C3AED),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.security,
                    size: 32,
                    color: Color(0xFF630ED4),
                  ),
                ),
                const SizedBox(height: 24),

                const Text(
                  "Verification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF630ED4),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Enter the 4-digit verification code\nsent to your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 32),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0x33CCC3D8),
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x147C3AED),
                        offset: Offset(0, 8),
                        blurRadius: 32,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Enter Verification Code",
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF151C27),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(4, (index) {
                          return SizedBox(
                            width: 56,
                            height: 60,
                            child: TextFormField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: const TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF630ED4),
                              ),
                              decoration: InputDecoration(
                                counterText: "",
                                filled: true,
                                fillColor: const Color(0xFFF9F9FF),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Color(0x33CCC3D8),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF630ED4),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 3) {
                                  _focusNodes[index + 1].requestFocus();
                                } else if (value.isEmpty && index > 0) {
                                  _focusNodes[index - 1].requestFocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "If you didn't receive a code? ",
                            style: TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              fontSize: 13,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                            },
                            child: const Text(
                              "Resend",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF630ED4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF630ED4), Color(0xFF7C3AED)],
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Perform code verification logic
                              Navigator.pushNamed(context, Routes.newPassword);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: const Text(
                              "Verify",
                              style: TextStyle(
                                fontFamily: 'Plus Jakarta Sans',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.arrow_back,
                        size: 16,
                        color: Color(0xFF630ED4),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Back to login",
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF630ED4),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Having trouble? ',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      TextSpan(
                        text: 'Contact Support',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF630ED4),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
