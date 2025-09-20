import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CourseBottomBar extends StatelessWidget {
  final Map<String, dynamic> courseData;
  final VoidCallback? onEnrollPressed;
  final VoidCallback? onPreviewPressed;

  const CourseBottomBar({
    Key? key,
    required this.courseData,
    this.onEnrollPressed,
    this.onPreviewPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isEnrolled = courseData["isEnrolled"] as bool? ?? false;
    final bool isFree = courseData["isFree"] as bool? ?? false;
    final String price = courseData["price"] as String? ?? "\$99";
    final double progress = (courseData["progress"] as num?)?.toDouble() ?? 0.0;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryDark,
        border: Border(
          top: BorderSide(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Progress Bar (for enrolled users)
            if (isEnrolled && progress > 0) ...[
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Course Progress",
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          height: 1.h,
                          decoration: BoxDecoration(
                            color: AppTheme.borderColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: progress,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.successTeal,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.successTeal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],

            // Action Buttons Row
            Row(
              children: [
                // Preview Button (if available)
                if (!isEnrolled && courseData["hasPreview"] == true) ...[
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: onPreviewPressed,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        side:
                            BorderSide(color: AppTheme.accentCoral, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'play_circle_outline',
                            color: AppTheme.accentCoral,
                            size: 20,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            "Preview",
                            style: AppTheme.darkTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme.accentCoral,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                ],

                // Main Action Button
                Expanded(
                  flex: isEnrolled || !courseData.containsKey("hasPreview")
                      ? 1
                      : 2,
                  child: ElevatedButton(
                    onPressed: onEnrollPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentCoral,
                      foregroundColor: AppTheme.textPrimary,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isEnrolled) ...[
                          CustomIconWidget(
                            iconName: 'play_arrow',
                            color: AppTheme.textPrimary,
                            size: 24,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            progress > 0 ? "Continue Learning" : "Start Course",
                            style: AppTheme.darkTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ] else ...[
                          if (!isFree) ...[
                            CustomIconWidget(
                              iconName: 'shopping_cart',
                              color: AppTheme.textPrimary,
                              size: 20,
                            ),
                            SizedBox(width: 2.w),
                          ],
                          Text(
                            isFree ? "Enroll for Free" : "Enroll Now - $price",
                            style: AppTheme.darkTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Additional Info for Paid Courses
            if (!isEnrolled && !isFree) ...[
              SizedBox(height: 1.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'security',
                    color: AppTheme.textTertiary,
                    size: 16,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    "30-day money-back guarantee",
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
