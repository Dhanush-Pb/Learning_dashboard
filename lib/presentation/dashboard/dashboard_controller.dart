import 'package:get/get.dart';
import 'package:learning_dashboard/data/repositories/course_repository.dart';

import '../../data/models/course_model.dart';

enum DashboardState {
  loading,
  success,
  empty,
  error,
}

class DashboardController extends GetxController {
  final CourseRepository repository;

  DashboardController({
    required this.repository,
  });

  final Rx<DashboardState> state =
      DashboardState.loading.obs;

  final RxList<CourseModel> courses =
      <CourseModel>[].obs;

  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();

    loadCourses();
  }

  Future<void> loadCourses() async {
    state.value = DashboardState.loading;

    try {
      final result = await repository.getCourses();

      if (result.isEmpty) {
        courses.clear();
        state.value = DashboardState.empty;
        return;
      }

      courses.assignAll(result);
      state.value = DashboardState.success;
    } catch (e) {
      errorMessage.value = 'Failed to load courses';
      state.value = DashboardState.error;
    }
  }

  Future<void> updateCourse(
    CourseModel updatedCourse,
  ) async {
    final index = courses.indexWhere(
      (course) => course.id == updatedCourse.id,
    );

    if (index == -1) {
      return;
    }

    // Update the course on the dashboard.
    courses[index] = updatedCourse;

    // Save the updated course to local cache.
    await repository.updateCourse(updatedCourse);
  }
}