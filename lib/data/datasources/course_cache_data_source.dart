import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/course_model.dart';

class CourseCacheDataSource {
  final SharedPreferences prefs;

  CourseCacheDataSource(this.prefs);

  static const String _cacheKey = 'cached_courses';

  Future<void> saveCourses(List<CourseModel> courses) async {
    final coursesJson = courses
        .map((course) => course.toJson())
        .toList();

    await prefs.setString(
      _cacheKey,
      jsonEncode(coursesJson),
    );
  }

  Future<List<CourseModel>> getCachedCourses() async {
    final cachedData = prefs.getString(_cacheKey);

    if (cachedData == null) {
      return [];
    }

    final List<dynamic> jsonData = jsonDecode(cachedData);

    return jsonData
        .map(
          (json) => CourseModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}