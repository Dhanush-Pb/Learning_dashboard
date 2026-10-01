import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/datasources/auth_local_data_source.dart';
import '../dashboard/dashboard_page.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final AuthLocalDataSource authDataSource;

  const LoginPage({
    super.key,
    required this.authDataSource,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const Color primary = Color(0xFF4F46E5);
  static const Color background = Color(0xFFF7F8FC);
  static const Color textPrimary = Color(0xFF171A21);
  static const Color textSecondary = Color(0xFF737984);
  static const Color border = Color(0xFFE3E5EC);

  late final LoginController controller;

  late final TextEditingController emailTextController;
  late final TextEditingController passwordTextController;

  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      LoginController(
        authDataSource: widget.authDataSource,
      ),
    );

    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    controller.emailController.value =
        emailTextController.text;

    controller.passwordController.value =
        passwordTextController.text;

    final success = await controller.login();

    if (success && mounted) {
      Get.offAll(
        () => const DashboardPage(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            24,
            32,
            24,
            24,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                _buildBrand(),

                const SizedBox(height: 46),

                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: textPrimary,
                    letterSpacing: -0.7,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Sign in to continue your learning journey.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: textSecondary,
                  ),
                ),

                const SizedBox(height: 32),

                _buildEmailField(),

                const SizedBox(height: 17),

                _buildPasswordField(),

                const SizedBox(height: 14),

                Obx(() {
                  final message =
                      controller.errorMessage.value;

                  if (message.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return _buildErrorMessage(message);
                }),

                const SizedBox(height: 22),

                Obx(() {
                  final isLoading =
                      controller.isLoading.value;

                  return SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed:
                          isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor:
                            primary.withValues(
                          alpha: 0.55,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2.2,
                                valueColor:
                                    AlwaysStoppedAnimation<
                                        Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight:
                                        FontWeight.w700,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons
                                      .arrow_forward_rounded,
                                  size: 19,
                                ),
                              ],
                            ),
                    ),
                  );
                }),

                const SizedBox(height: 28),

                _buildInfoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4338CA),
                Color(0xFF7C73F2),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: primary.withValues(alpha: 0.20),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.school_rounded,
            color: Colors.white,
            size: 27,
          ),
        ),

        const SizedBox(width: 13),

        const Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Learning Dashboard',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: textPrimary,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Your learning space',
              style: TextStyle(
                fontSize: 11,
                color: textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Email address',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: emailTextController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            controller.emailController.value =
                value;

            if (controller.errorMessage.value
                .isNotEmpty) {
              controller.errorMessage.value = '';
            }
          },
          decoration: InputDecoration(
            hintText: 'Enter your email',
            hintStyle: const TextStyle(
              color: Color(0xFFA1A6B0),
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.email_outlined,
              size: 20,
              color: textSecondary,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: passwordTextController,
          obscureText: obscurePassword,
          textInputAction: TextInputAction.done,
          onChanged: (value) {
            controller.passwordController.value =
                value;

            if (controller.errorMessage.value
                .isNotEmpty) {
              controller.errorMessage.value = '';
            }
          },
          onSubmitted: (_) => _login(),
          decoration: InputDecoration(
            hintText: 'Enter your password',
            hintStyle: const TextStyle(
              color: Color(0xFFA1A6B0),
              fontSize: 14,
            ),
            prefixIcon: const Icon(
              Icons.lock_outline_rounded,
              size: 20,
              color: textSecondary,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscurePassword =
                      !obscurePassword;
                });
              },
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
                color: textSecondary,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 17,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFFD3D3),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 18,
            color: Color(0xFFD93025),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFFD93025),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF0FF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFDDE0FF),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.security_rounded,
            size: 20,
            color: primary,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Your session is securely saved on this device.',
              style: TextStyle(
                fontSize: 11,
                height: 1.4,
                color: Color(0xFF555B66),
              ),
            ),
          ),
        ],
      ),
    );
  }
}