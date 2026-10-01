import 'package:learning_dashboard/data/repositories/course_repository.dart';

import '../datasources/course_cache_data_source.dart';
import '../datasources/course_local_data_source.dart';
import '../models/course_model.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseLocalDataSource localDataSource;
  final CourseCacheDataSource cacheDataSource;

  CourseRepositoryImpl({
    required this.localDataSource,
    required this.cacheDataSource,
  });

  @override
  Future<List<CourseModel>> getCourses() async {
    // First check local cache
    final cachedCourses =
        await cacheDataSource.getCachedCourses();

    // If cache exists, use it
    if (cachedCourses.isNotEmpty) {
      return cachedCourses;
    }

    // No cache exists, load initial data
    try {
      final courses =
          await localDataSource.getCoursesFromJson();

      // Save initial data to cache
      await cacheDataSource.saveCourses(courses);

      return courses;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> updateCourse(
    CourseModel course,
  ) async {
    final cachedCourses =
        await cacheDataSource.getCachedCourses();

    final index = cachedCourses.indexWhere(
      (item) => item.id == course.id,
    );

    if (index == -1) {
      return;
    }

    cachedCourses[index] = course;

    await cacheDataSource.saveCourses(cachedCourses);
  }
}