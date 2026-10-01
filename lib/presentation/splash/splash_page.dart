import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/datasources/auth_local_data_source.dart';
import '../dashboard/dashboard_page.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  final AuthLocalDataSource authDataSource;

  const SplashPage({
    super.key,
    required this.authDataSource,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Give the splash screen a short display time.
    await Future.delayed(
      const Duration(milliseconds: 1500),
    );

    if (!mounted) return;

    final isLoggedIn = widget.authDataSource.isLoggedIn;

    if (isLoggedIn) {
      Get.offAll(
        () => const DashboardPage(),
      );
    } else {
      Get.offAll(
        () => LoginPage(
          authDataSource: widget.authDataSource,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4F46E5),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4338CA),
              Color(0xFF6366F1),
              Color(0xFF7C73F2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.15,
                  ),
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: Colors.white.withValues(
                      alpha: 0.18,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 46,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Learning Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Learn. Progress. Grow.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 38),

              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}