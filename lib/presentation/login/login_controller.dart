import 'package:get/get.dart';

import '../../data/datasources/auth_local_data_source.dart';

class LoginController extends GetxController {
  final AuthLocalDataSource authDataSource;

  LoginController({
    required this.authDataSource,
  });

  final emailController = ''.obs;
  final passwordController = ''.obs;

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<bool> login() async {
    errorMessage.value = '';

    if (emailController.value.trim().isEmpty) {
      errorMessage.value = 'Please enter your email';
      return false;
    }

    if (!GetUtils.isEmail(emailController.value.trim())) {
      errorMessage.value = 'Please enter a valid email';
      return false;
    }

 if (passwordController.value.isEmpty) {
  errorMessage.value = 'Please enter your password';
  return false;
}

if (passwordController.value.length < 6) {
  errorMessage.value =
      'Password must be at least 6 characters';
  return false;
}

if (!RegExp(r'[A-Z]').hasMatch(passwordController.value)) {
  errorMessage.value =
      'Password must contain at least one uppercase letter';
  return false;
}

if (!RegExp(r'[0-9]').hasMatch(passwordController.value)) {
  errorMessage.value =
      'Password must contain at least one number';
  return false;
}

    isLoading.value = true;

    // Mock login API
    await Future.delayed(
      const Duration(seconds: 1),
    );

    isLoading.value = false;

    await authDataSource.saveLoginStatus(true);

    return true;
  }
}