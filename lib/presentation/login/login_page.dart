import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/datasources/auth_local_data_source.dart';
import '../dashboard/dashboard_page.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  final AuthLocalDataSource authDataSource;

  LoginPage({
    super.key,
    required this.authDataSource,
  });

  late final LoginController controller =
      Get.put(
        LoginController(
          authDataSource: authDataSource,
        ),
      );

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Learning Dashboard',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 32),

            TextField(
              controller: emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                controller.emailController.value = value;
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: passwordTextController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                controller.passwordController.value = value;
              },
            ),

            const SizedBox(height: 16),

            Obx(() {
              if (controller.errorMessage.value.isEmpty) {
                return const SizedBox.shrink();
              }

              return Text(
                controller.errorMessage.value,
                style: const TextStyle(
                  color: Colors.red,
                ),
              );
            }),

            const SizedBox(height: 16),

            Obx(() {
              return SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          final success =
                              await controller.login();

                          if (success) {
                            Get.off(
                              () => const DashboardPage(),
                            );
                          }
                        },
                  child: controller.isLoading.value
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Login'),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}