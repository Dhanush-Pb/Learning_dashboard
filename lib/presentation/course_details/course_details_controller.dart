import 'package:get/get.dart';

import '../../data/models/course_model.dart';
import '../../data/models/lesson_model.dart';

class CourseDetailsController extends GetxController {
  final CourseModel course;

  CourseDetailsController({required this.course});

  final RxList<LessonModel> lessons = <LessonModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    lessons.assignAll(course.lessons);
  }

  void toggleLesson(int index) {
    final lesson = lessons[index];

    lessons[index] = lesson.copyWith(isCompleted: !lesson.isCompleted);
  }

  int get progress {
    if (lessons.isEmpty) {
      return 0;
    }

    final completedLessons = lessons
        .where((lesson) => lesson.isCompleted)
        .length;

    return ((completedLessons / lessons.length) * 100).round();
  }

  CourseModel get updatedCourse {
    return course.copyWith(lessons: lessons.toList());
  }
}
