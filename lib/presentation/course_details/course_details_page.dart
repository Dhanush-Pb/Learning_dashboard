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

  static const Color primary = Color(0xFF4F46E5);
  static const Color background = Color(0xFFF7F8FC);
  static const Color textPrimary = Color(0xFF171A21);
  static const Color textSecondary = Color(0xFF737984);
  static const Color border = Color(0xFFE8EAF0);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CourseDetailsController(
        course: course,
      ),
    );

    return Scaffold(
      backgroundColor: background,
      body: Obx(
        () {
          final progress = controller.progress;

          return CustomScrollView(
            slivers: [
              _buildAppBar(controller),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  18,
                  20,
                  30,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      _buildCourseHero(progress),

                      const SizedBox(height: 28),

                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Course Lessons',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    color: textPrimary,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Complete each lesson to track your progress.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 11,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(20),
                              border: Border.all(
                                color: border,
                              ),
                            ),
                            child: Text(
                              '${controller.lessons.where((lesson) => lesson.isCompleted).length}/${controller.lessons.length}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: primary,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 17),

                      ...List.generate(
                        controller.lessons.length,
                        (index) {
                          final lesson =
                              controller.lessons[index];

                          return Padding(
                            padding:
                                const EdgeInsets.only(
                              bottom: 11,
                            ),
                            child: _buildLessonCard(
                              index: index,
                              title: lesson.title,
                              isCompleted:
                                  lesson.isCompleted,
                              onChanged: () {
                                controller.toggleLesson(
                                  index,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar(
    CourseDetailsController controller,
  ) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          onPressed: () {
            Get.back(
              result: controller.updatedCourse,
            );
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: textPrimary,
          ),
        ),
      ),
      title: const Text(
        'Course Details',
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),
      ),
    );
  }

  Widget _buildCourseHero(int progress) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4338CA),
            Color(0xFF6366F1),
            Color(0xFF7C73F2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.20),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color:
                        Colors.white.withValues(alpha: 0.12),
                  ),
                ),
                child: const Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.person_outline_rounded,
                          size: 15,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            course.instructor,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 27),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your progress',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$progress%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress / 100,
              minHeight: 9,
              backgroundColor:
                  Colors.white.withValues(alpha: 0.18),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              _buildHeroInfo(
                Icons.play_lesson_outlined,
                '${course.lessonCount} Lessons',
              ),
              const SizedBox(width: 18),
              _buildHeroInfo(
                Icons.check_circle_outline_rounded,
                '${course.lessons.where((lesson) => lesson.isCompleted).length} Completed',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroInfo(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.white70,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildLessonCard({
    required int index,
    required String title,
    required bool isCompleted,
    required VoidCallback onChanged,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onChanged,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isCompleted
                  ? const Color(0xFFD4EDDD)
                  : border,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.025),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFFE8F7EE)
                      : const Color(0xFFF0F1F5),
                  shape: BoxShape.circle,
                ),
                child: isCompleted
                    ? const Icon(
                        Icons.check_rounded,
                        color: Color(0xFF16834A),
                        size: 21,
                      )
                    : Text(
                        '${index + 1}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: textSecondary,
                        ),
                      ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: isCompleted
                            ? const Color(0xFF59606C)
                            : textPrimary,
                        height: 1.3,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          isCompleted
                              ? Icons.check_circle_outline
                              : Icons.play_circle_outline,
                          size: 14,
                          color: isCompleted
                              ? const Color(0xFF16834A)
                              : textSecondary,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          isCompleted
                              ? 'Completed'
                              : 'Ready to learn',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: isCompleted
                                ? const Color(0xFF16834A)
                                : textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Checkbox(
                value: isCompleted,
                onChanged: (_) => onChanged(),
                activeColor: primary,
                side: const BorderSide(
                  color: Color(0xFFB9BDC7),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}