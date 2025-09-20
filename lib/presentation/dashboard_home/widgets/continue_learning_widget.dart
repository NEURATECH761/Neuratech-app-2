import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ContinueLearningWidget extends StatelessWidget {
  const ContinueLearningWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> continueCourses = [
      {
        "id": 1,
        "title": "Flutter Development Masterclass",
        "instructor": "Sarah Johnson",
        "progress": 0.65,
        "image":
            "https://images.unsplash.com/photo-1517077304055-6e89abbf09b0?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
        "duration": "12 hours",
        "completedLessons": 13,
        "totalLessons": 20,
      },
      {
        "id": 2,
        "title": "UI/UX Design Fundamentals",
        "instructor": "Michael Chen",
        "progress": 0.35,
        "image":
            "https://images.unsplash.com/photo-1561070791-2526d30994b5?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
        "duration": "8 hours",
        "completedLessons": 7,
        "totalLessons": 20,
      },
      {
        "id": 3,
        "title": "Data Science with Python",
        "instructor": "Dr. Emily Rodriguez",
        "progress": 0.80,
        "image":
            "https://images.unsplash.com/photo-1551288049-bebda4e38f71?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
        "duration": "15 hours",
        "completedLessons": 16,
        "totalLessons": 20,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Continue Learning',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/course-catalog'),
                child: Text(
                  'View All',
                  style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.accentCoral,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 28.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            itemCount: continueCourses.length,
            itemBuilder: (context, index) {
              final course = continueCourses[index];
              return _buildContinueCourseCard(context, course);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContinueCourseCard(
      BuildContext context, Map<String, dynamic> course) {
    return Container(
      width: 70.w,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CustomImageWidget(
              imageUrl: course["image"] as String,
              width: double.infinity,
              height: 12.h,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course["title"] as String,
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'by ${course["instructor"]}',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'play_circle_outline',
                        color: AppTheme.textSecondary,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${course["completedLessons"]}/${course["totalLessons"]} lessons',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Progress',
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          Text(
                            '${((course["progress"] as double) * 100).toInt()}%',
                            style: AppTheme.darkTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.accentCoral,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5.h),
                      LinearProgressIndicator(
                        value: course["progress"] as double,
                        backgroundColor: AppTheme.borderColor,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppTheme.accentCoral),
                        minHeight: 4,
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/course-player'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentCoral,
                        padding: EdgeInsets.symmetric(vertical: 1.5.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style:
                            AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
