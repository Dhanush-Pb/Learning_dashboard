import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/course_model.dart';
import 'course_details_controller.dart';

class CourseDetailsPage extends StatelessWidget {
  final CourseModel course;

  const CourseDetailsPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CourseDetailsController(
        course: course,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(
              result: controller.updatedCourse,
            );
          },
        ),
      ),
      body: Obx(
        () {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Instructor: ${course.instructor}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  '${controller.progress}% completed',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                LinearProgressIndicator(
                  value: controller.progress / 100,
                ),

                const SizedBox(height: 24),

                const Text(
                  'Lessons',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: ListView.builder(
                    itemCount: controller.lessons.length,
                    itemBuilder: (context, index) {
                      final lesson = controller.lessons[index];

                      return Card(
                        margin: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: CheckboxListTile(
                          value: lesson.isCompleted,
                          title: Text(lesson.title),
                          controlAffinity:
                              ListTileControlAffinity.leading,
                          onChanged: (_) {
                            controller.toggleLesson(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}