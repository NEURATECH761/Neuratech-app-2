import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CourseHeroSection extends StatelessWidget {
  final Map<String, dynamic> courseData;

  const CourseHeroSection({
    Key? key,
    required this.courseData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      child: Stack(
        children: [
          // Hero Image with Parallax Effect
          Positioned.fill(
            child: Hero(
              tag: 'course-image-${courseData["id"]}',
              child: CustomImageWidget(
                imageUrl: courseData["image"] as String? ?? "",
                width: double.infinity,
                height: 35.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppTheme.primaryDark.withValues(alpha: 0.3),
                    AppTheme.primaryDark.withValues(alpha: 0.8),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Course Information
          Positioned(
            bottom: 2.h,
            left: 4.w,
            right: 4.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course Title
                Text(
                  courseData["title"] as String? ?? "Course Title",
                  style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 1.h),

                // Instructor and Rating Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "By ${courseData["instructor"] as String? ?? "Unknown Instructor"}",
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: 0.5.h),

                          // Rating and Students
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'star',
                                color: AppTheme.warningYellow,
                                size: 16,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                "${courseData["rating"] ?? "4.5"}",
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                "(${courseData["students"] ?? "1,234"} students)",
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Bookmark Button
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.primaryDark.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Handle bookmark toggle
                        },
                        icon: CustomIconWidget(
                          iconName: 'bookmark_border',
                          color: AppTheme.textPrimary,
                          size: 24,
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
    );
  }
}
