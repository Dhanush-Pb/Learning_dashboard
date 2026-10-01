import 'package:flutter_test/flutter_test.dart';

import 'package:learning_dashboard/data/models/course_model.dart';
import 'package:learning_dashboard/data/models/lesson_model.dart';

void main() {
  test('course progress should calculate correctly', () {
    final course = CourseModel(
      id: 1,
      title: 'Python Programming',
      instructor: 'John Smith',
      lessons: [
        LessonModel(id: 1, title: 'Introduction', isCompleted: true),
        LessonModel(id: 2, title: 'Variables', isCompleted: true),
        LessonModel(id: 3, title: 'Functions', isCompleted: false),
        LessonModel(id: 4, title: 'OOP', isCompleted: false),
      ],
    );

    expect(course.progress, 50);
  });
}
