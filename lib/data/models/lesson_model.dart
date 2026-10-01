class LessonModel {
  final int id;
  final String title;
  final bool isCompleted;

  LessonModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  LessonModel copyWith({
    int? id,
    String? title,
    bool? isCompleted,
  }) {
    return LessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as int,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }
}