import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/course_model.dart';

class CourseLocalDataSource {
  Future<List<CourseModel>> getCoursesFromJson() async {
    final jsonString = await rootBundle.loadString(
      'assets/courses.json',
    );

    final List<dynamic> jsonData = json.decode(jsonString);

    return jsonData
        .map((json) => CourseModel.fromJson(json))
        .toList();
  }
}