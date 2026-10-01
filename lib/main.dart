import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_dashboard/data/repositories/course_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/course_cache_data_source.dart';
import 'data/datasources/course_local_data_source.dart';
import 'data/repositories/course_repository_impl.dart';

import 'presentation/dashboard/dashboard_controller.dart';
import 'presentation/dashboard/dashboard_page.dart';
import 'presentation/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final authDataSource = AuthLocalDataSource(prefs);

  final localDataSource = CourseLocalDataSource();

  final cacheDataSource = CourseCacheDataSource(prefs);

  final CourseRepository repository = CourseRepositoryImpl(
    localDataSource: localDataSource,
    cacheDataSource: cacheDataSource,
  );

  Get.put<DashboardController>(
    DashboardController(
      repository: repository,
    ),
  );

  final isLoggedIn = authDataSource.isLoggedIn;

  runApp(
    LearningDashboardApp(
      isLoggedIn: isLoggedIn,
      authDataSource: authDataSource,
    ),
  );
}

class LearningDashboardApp extends StatelessWidget {
  final bool isLoggedIn;
  final AuthLocalDataSource authDataSource;

  const LearningDashboardApp({
    super.key,
    required this.isLoggedIn,
    required this.authDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Dashboard',
  home: isLoggedIn
    ? const DashboardPage()
    : LoginPage(
        authDataSource: authDataSource,
      ),
    );
  }
}