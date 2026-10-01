import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_dashboard/data/repositories/course_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/course_cache_data_source.dart';
import 'data/datasources/course_local_data_source.dart';
import 'data/repositories/course_repository_impl.dart';

import 'presentation/dashboard/dashboard_controller.dart';
import 'presentation/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final authDataSource = AuthLocalDataSource(prefs);

  final localDataSource = CourseLocalDataSource();

  final cacheDataSource =
      CourseCacheDataSource(prefs);
Get.put<AuthLocalDataSource>(authDataSource);
  final CourseRepository repository =
      CourseRepositoryImpl(
    localDataSource: localDataSource,
    cacheDataSource: cacheDataSource,
  );

  Get.put<DashboardController>(
    DashboardController(
      repository: repository,
    ),
  );

  runApp(
    LearningDashboardApp(
      authDataSource: authDataSource,
    ),
  );
}

class LearningDashboardApp extends StatelessWidget {
  final AuthLocalDataSource authDataSource;

  const LearningDashboardApp({
    super.key,
    required this.authDataSource,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning Dashboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
        ),
        useMaterial3: true,
      ),
      home: SplashPage(
        authDataSource: authDataSource,
      ),
    );
  }
}