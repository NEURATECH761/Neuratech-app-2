import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NewCoursesWidget extends StatelessWidget {
  const NewCoursesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> newCourses = [
      {
        "id": 1,
        "title": "Advanced React Native Development",
        "instructor": "Alex Thompson",
        "rating": 4.8,
        "students": 2340,
        "price": "\$89.99",
        "originalPrice": "\$129.99",
        "image":
            "https://images.unsplash.com/photo-1555066931-4365d14bab8c?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
        "duration": "18 hours",
        "level": "Advanced",
        "isNew": true,
      },
      {
        "id": 2,
        "title": "Machine Learning Fundamentals",
        "instructor": "Dr. Lisa Wang",
        "rating": 4.9,
        "students": 1890,
        "price": "\$79.99",
        "originalPrice": "\$119.99",
        "image":
            "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
        "duration": "22 hours",
        "level": "Beginner",
        "isNew": true,
      },
      {
        "id": 3,
        "title": "Digital Marketing Strategy 2024",
        "instructor": "Maria Garcia",
        "rating": 4.7,
        "students": 3120,
        "price": "\$69.99",
        "originalPrice": "\$99.99",
        "image":
            "https://images.unsplash.com/photo-1460925895917-afdab827c52f?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
        "duration": "14 hours",
        "level": "Intermediate",
        "isNew": true,
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
                'New Courses',
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
          height: 32.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            itemCount: newCourses.length,
            itemBuilder: (context, index) {
              final course = newCourses[index];
              return _buildNewCourseCard(context, course);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNewCourseCard(
      BuildContext context, Map<String, dynamic> course) {
    return Container(
      width: 75.w,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: CustomImageWidget(
                  imageUrl: course["image"] as String,
                  width: double.infinity,
                  height: 14.h,
                  fit: BoxFit.cover,
                ),
              ),
              if (course["isNew"] == true)
                Positioned(
                  top: 2.w,
                  left: 2.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: AppTheme.accentCoral,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'NEW',
                      style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 2.w,
                right: 2.w,
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryDark.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomIconWidget(
                    iconName: 'bookmark_border',
                    color: AppTheme.textPrimary,
                    size: 18,
                  ),
                ),
              ),
            ],
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
                        iconName: 'star',
                        color: AppTheme.warningYellow,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        '${course["rating"]}',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '(${course["students"]} students)',
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppTheme.successTeal.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          course["level"] as String,
                          style:
                              AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.successTeal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      CustomIconWidget(
                        iconName: 'access_time',
                        color: AppTheme.textSecondary,
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        course["duration"] as String,
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course["price"] as String,
                            style: AppTheme.darkTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme.accentCoral,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if (course["originalPrice"] != null)
                            Text(
                              course["originalPrice"] as String,
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textTertiary,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/course-detail'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentCoral,
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Start Course',
                          style:
                              AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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
