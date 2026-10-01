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
    try {
      final courses = await localDataSource.getCoursesFromJson();

      await cacheDataSource.saveCourses(courses);

      return courses;
    } catch (e) {
      return await cacheDataSource.getCachedCourses();
    }
  }

  @override
  Future<void> updateCourse(CourseModel course) async {
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