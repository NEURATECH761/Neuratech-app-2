import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecommendedCoursesWidget extends StatelessWidget {
  const RecommendedCoursesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recommendedCourses = [
      {
        "id": 1,
        "title": "Complete Web Development Bootcamp",
        "instructor": "David Miller",
        "rating": 4.9,
        "students": 4560,
        "price": "\$94.99",
        "originalPrice": "\$149.99",
        "image":
            "https://images.unsplash.com/photo-1498050108023-c5249f4df085?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
        "duration": "42 hours",
        "level": "All Levels",
        "matchPercentage": 95,
        "tags": ["HTML", "CSS", "JavaScript", "React"],
      },
      {
        "id": 2,
        "title": "iOS App Development with Swift",
        "instructor": "Jennifer Lee",
        "rating": 4.8,
        "students": 2890,
        "price": "\$84.99",
        "originalPrice": "\$129.99",
        "image":
            "https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
        "duration": "28 hours",
        "level": "Intermediate",
        "matchPercentage": 88,
        "tags": ["Swift", "iOS", "Xcode", "UIKit"],
      },
      {
        "id": 3,
        "title": "Data Analysis with Excel & Power BI",
        "instructor": "Robert Chen",
        "rating": 4.7,
        "students": 3240,
        "price": "\$59.99",
        "originalPrice": "\$89.99",
        "image":
            "https://images.unsplash.com/photo-1551288049-bebda4e38f71?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
        "duration": "16 hours",
        "level": "Beginner",
        "matchPercentage": 82,
        "tags": ["Excel", "Power BI", "Analytics", "Charts"],
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended for You',
                    style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'Based on your learning preferences',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: recommendedCourses.length,
          itemBuilder: (context, index) {
            final course = recommendedCourses[index];
            return _buildRecommendedCourseCard(context, course);
          },
        ),
      ],
    );
  }

  Widget _buildRecommendedCourseCard(
      BuildContext context, Map<String, dynamic> course) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/course-detail'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(3.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomImageWidget(
                      imageUrl: course["image"] as String,
                      width: 25.w,
                      height: 15.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 1.w,
                    left: 1.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.5.w, vertical: 0.3.h),
                      decoration: BoxDecoration(
                        color: AppTheme.successTeal,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${course["matchPercentage"]}% match',
                        style:
                            AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 3.w),
              Expanded(
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
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '${course["rating"]}',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        CustomIconWidget(
                          iconName: 'people',
                          color: AppTheme.textSecondary,
                          size: 14,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          '${course["students"]}',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 1.h),
                    Wrap(
                      spacing: 1.w,
                      runSpacing: 0.5.h,
                      children: (course["tags"] as List).take(3).map((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.3.h),
                          decoration: BoxDecoration(
                            color: AppTheme.accentCoral.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tag as String,
                            style: AppTheme.darkTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.accentCoral,
                              fontWeight: FontWeight.w500,
                              fontSize: 9.sp,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 1.5.h),
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
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: CustomIconWidget(
                                iconName: 'bookmark_border',
                                color: AppTheme.textSecondary,
                                size: 20,
                              ),
                              padding: EdgeInsets.all(1.w),
                              constraints: BoxConstraints(
                                minWidth: 8.w,
                                minHeight: 4.h,
                              ),
                            ),
                            SizedBox(width: 1.w),
                            ElevatedButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, '/course-detail'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.accentCoral,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4.w, vertical: 1.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Enroll',
                                style: AppTheme.darkTheme.textTheme.titleSmall
                                    ?.copyWith(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
