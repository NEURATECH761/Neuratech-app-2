import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CourseTabContent extends StatelessWidget {
  final Map<String, dynamic> courseData;

  const CourseTabContent({
    Key? key,
    required this.courseData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // Tab Bar
          Container(
            color: AppTheme.primaryDark,
            child: TabBar(
              labelColor: AppTheme.accentCoral,
              unselectedLabelColor: AppTheme.textSecondary,
              indicatorColor: AppTheme.accentCoral,
              indicatorWeight: 3,
              labelStyle: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle:
                  AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
              tabs: const [
                Tab(text: "Overview"),
                Tab(text: "Curriculum"),
                Tab(text: "Reviews"),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              children: [
                _buildOverviewTab(),
                _buildCurriculumTab(),
                _buildReviewsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    final List<String> learningOutcomes =
        (courseData["learningOutcomes"] as List?)?.cast<String>() ?? [];
    final List<String> prerequisites =
        (courseData["prerequisites"] as List?)?.cast<String>() ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Course Description
          Text(
            "Course Description",
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),

          Text(
            courseData["description"] as String? ?? "No description available",
            style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.6,
            ),
          ),

          SizedBox(height: 3.h),

          // Learning Outcomes
          if (learningOutcomes.isNotEmpty) ...[
            Text(
              "What You'll Learn",
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            ...learningOutcomes
                .map((outcome) => Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 0.5.h, right: 3.w),
                            child: CustomIconWidget(
                              iconName: 'check_circle',
                              color: AppTheme.successTeal,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              outcome,
                              style: AppTheme.darkTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            SizedBox(height: 3.h),
          ],

          // Prerequisites
          if (prerequisites.isNotEmpty) ...[
            Text(
              "Prerequisites",
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            ...prerequisites
                .map((prerequisite) => Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 0.5.h, right: 3.w),
                            child: CustomIconWidget(
                              iconName: 'arrow_right',
                              color: AppTheme.accentCoral,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              prerequisite,
                              style: AppTheme.darkTheme.textTheme.bodyMedium
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            SizedBox(height: 3.h),
          ],

          // Course Details
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Column(
              children: [
                _buildDetailRow(
                    "Duration", "${courseData["duration"] ?? "8 weeks"}"),
                SizedBox(height: 2.h),
                _buildDetailRow(
                    "Level", "${courseData["level"] ?? "Intermediate"}"),
                SizedBox(height: 2.h),
                _buildDetailRow(
                    "Language", "${courseData["language"] ?? "English"}"),
                SizedBox(height: 2.h),
                _buildDetailRow("Certificate",
                    courseData["certificate"] == true ? "Yes" : "No"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurriculumTab() {
    final List<Map<String, dynamic>> modules =
        (courseData["modules"] as List?)?.cast<Map<String, dynamic>>() ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Course Curriculum",
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),
          if (modules.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.surfaceCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Text(
                "Curriculum information will be available soon.",
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ] else ...[
            ...modules.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> module = entry.value;
              final List<Map<String, dynamic>> lessons =
                  (module["lessons"] as List?)?.cast<Map<String, dynamic>>() ??
                      [];

              return Container(
                margin: EdgeInsets.only(bottom: 2.h),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: ExpansionTile(
                  tilePadding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  childrenPadding: EdgeInsets.only(bottom: 2.h),
                  leading: Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: AppTheme.accentCoral,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style:
                            AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    module["title"] as String? ?? "Module ${index + 1}",
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    "${lessons.length} lessons • ${module["duration"] ?? "2 hours"}",
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  iconColor: AppTheme.accentCoral,
                  collapsedIconColor: AppTheme.textSecondary,
                  children: lessons
                      .map((lesson) => Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 0.5.h),
                            padding: EdgeInsets.all(3.w),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryDark,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                CustomIconWidget(
                                  iconName: lesson["type"] == "video"
                                      ? 'play_circle_outline'
                                      : 'article',
                                  color: AppTheme.textSecondary,
                                  size: 20,
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lesson["title"] as String? ?? "Lesson",
                                        style: AppTheme
                                            .darkTheme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      if (lesson["duration"] != null) ...[
                                        SizedBox(height: 0.5.h),
                                        Text(
                                          "${lesson["duration"]}",
                                          style: AppTheme
                                              .darkTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppTheme.textTertiary,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                if (lesson["completed"] == true)
                                  CustomIconWidget(
                                    iconName: 'check_circle',
                                    color: AppTheme.successTeal,
                                    size: 20,
                                  )
                                else
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppTheme.borderColor,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    final List<Map<String, dynamic>> reviews =
        (courseData["reviews"] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final double averageRating =
        (courseData["rating"] as num?)?.toDouble() ?? 4.5;

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating Summary
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.surfaceCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        averageRating.toStringAsFixed(1),
                        style:
                            AppTheme.darkTheme.textTheme.displaySmall?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: List.generate(
                            5,
                            (index) => Padding(
                                  padding: EdgeInsets.only(right: 1.w),
                                  child: CustomIconWidget(
                                    iconName: index < averageRating.floor()
                                        ? 'star'
                                        : 'star_border',
                                    color: AppTheme.warningYellow,
                                    size: 20,
                                  ),
                                )),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "${courseData["totalReviews"] ?? reviews.length} reviews",
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Rating Distribution (simplified)
                Expanded(
                  child: Column(
                    children: List.generate(5, (index) {
                      final rating = 5 - index;
                      final percentage = (rating == 5
                          ? 0.6
                          : rating == 4
                              ? 0.3
                              : 0.1);

                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 0.5.h),
                        child: Row(
                          children: [
                            Text(
                              "$rating",
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Container(
                                height: 1.h,
                                decoration: BoxDecoration(
                                  color: AppTheme.borderColor,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: percentage,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.warningYellow,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 3.h),

          // Reviews List
          Text(
            "Student Reviews",
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2.h),

          if (reviews.isEmpty) ...[
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.surfaceCard,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderColor),
              ),
              child: Text(
                "No reviews yet. Be the first to review this course!",
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ] else ...[
            ...reviews
                .map((review) => Container(
                      margin: EdgeInsets.only(bottom: 2.h),
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.borderColor),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 5.w,
                                backgroundColor: AppTheme.accentCoral,
                                child: Text(
                                  (review["userName"] as String? ?? "U")[0]
                                      .toUpperCase(),
                                  style: AppTheme
                                      .darkTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review["userName"] as String? ??
                                          "Anonymous",
                                      style: AppTheme
                                          .darkTheme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: AppTheme.textPrimary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ...List.generate(
                                            5,
                                            (index) => Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 0.5.w),
                                                  child: CustomIconWidget(
                                                    iconName: index <
                                                            (review["rating"]
                                                                    as num? ??
                                                                5)
                                                        ? 'star'
                                                        : 'star_border',
                                                    color:
                                                        AppTheme.warningYellow,
                                                    size: 16,
                                                  ),
                                                )),
                                        SizedBox(width: 2.w),
                                        Text(
                                          review["date"] as String? ??
                                              "Recently",
                                          style: AppTheme
                                              .darkTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppTheme.textTertiary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            review["comment"] as String? ?? "",
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
