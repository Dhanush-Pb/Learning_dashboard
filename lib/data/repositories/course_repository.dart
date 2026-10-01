import '../../data/models/course_model.dart';

abstract class CourseRepository {
  Future<List<CourseModel>> getCourses();

  Future<void> updateCourse(CourseModel course);
}