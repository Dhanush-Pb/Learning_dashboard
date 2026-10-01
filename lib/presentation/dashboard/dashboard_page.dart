import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_dashboard/data/models/course_model.dart';

import '../course_details/course_details_page.dart';
import 'dashboard_controller.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
      ),
      body: Obx(
        () {
          switch (controller.state.value) {
            case DashboardState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case DashboardState.empty:
              return const Center(
                child: Text('No courses available'),
              );

            case DashboardState.error:
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(controller.errorMessage.value),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: controller.loadCourses,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );

            case DashboardState.success:
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.courses.length,
                itemBuilder: (context, index) {
                  final course = controller.courses[index];

                  return Card(
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            'Instructor: ${course.instructor}',
                          ),

                          const SizedBox(height: 6),

                          Text(
                            '${course.progress}% completed',
                          ),

                          const SizedBox(height: 6),

                          Text(
                            '${course.lessonCount} lessons',
                          ),

                          const SizedBox(height: 12),

                          LinearProgressIndicator(
                            value: course.progress / 100,
                          ),

                          const SizedBox(height: 12),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final updatedCourse =
                                    await Get.to<CourseModel>(
                                  () => CourseDetailsPage(
                                    course: course,
                                  ),
                                );

                                if (updatedCourse != null) {
                                  controller.updateCourse(
                                    updatedCourse,
                                  );
                                }
                              },
                              child: const Text('Continue'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}