import 'lesson_model.dart';

class CourseModel {
  final int id;
  final String title;
  final String instructor;
  final List<LessonModel> lessons;

  CourseModel({
    required this.id,
    required this.title,
    required this.instructor,
    required this.lessons,
  });

  int get progress {
    if (lessons.isEmpty) {
      return 0;
    }

    final completedLessons =
        lessons.where((lesson) => lesson.isCompleted).length;

    return ((completedLessons / lessons.length) * 100).round();
  }

  int get lessonCount => lessons.length;

  CourseModel copyWith({
    int? id,
    String? title,
    String? instructor,
    List<LessonModel>? lessons,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      instructor: instructor ?? this.instructor,
      lessons: lessons ?? this.lessons,
    );
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    final lessonsJson = json['lessons'] as List<dynamic>;

    return CourseModel(
      id: json['id'] as int,
      title: json['title'] as String,
      instructor: json['instructor'] as String,
      lessons: lessonsJson
          .map(
            (lesson) =>
                LessonModel.fromJson(lesson as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instructor': instructor,
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
    };
  }
}