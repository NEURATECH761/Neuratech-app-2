import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CourseGridWidget extends StatelessWidget {
  final List<Map<String, dynamic>> courses;
  final bool isLoading;
  final VoidCallback onRefresh;
  final Function(Map<String, dynamic>) onCourseTap;

  const CourseGridWidget({
    Key? key,
    required this.courses,
    required this.isLoading,
    required this.onRefresh,
    required this.onCourseTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading && courses.isEmpty) {
      return _buildSkeletonGrid();
    }

    if (courses.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        onRefresh();
        await Future.delayed(const Duration(milliseconds: 500));
      },
      color: AppTheme.accentCoral,
      backgroundColor: AppTheme.secondaryDark,
      child: GridView.builder(
        padding: EdgeInsets.all(4.w),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 2.h,
        ),
        itemCount: courses.length + (isLoading ? 4 : 0),
        itemBuilder: (context, index) {
          if (index >= courses.length) {
            return _buildSkeletonCard();
          }
          return _buildCourseCard(courses[index]);
        },
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return GestureDetector(
      onTap: () => onCourseTap(course),
      onLongPress: () => _showQuickActions(course),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.darkTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Course Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: CustomImageWidget(
                        imageUrl: course['image'] as String,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Difficulty Badge
                    Positioned(
                      top: 1.h,
                      left: 2.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(
                              course['difficulty'] as String),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          course['difficulty'] as String,
                          style:
                              AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.textPrimary,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    // Bookmark Icon
                    Positioned(
                      top: 1.h,
                      right: 2.w,
                      child: Container(
                        padding: EdgeInsets.all(1.w),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryDark.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: CustomIconWidget(
                          iconName: course['isBookmarked'] == true
                              ? 'bookmark'
                              : 'bookmark_border',
                          color: AppTheme.textPrimary,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Course Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course['title'] as String,
                      style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      course['instructor'] as String,
                      style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'star',
                              color: AppTheme.warningYellow,
                              size: 14,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              course['rating'].toString(),
                              style: AppTheme.darkTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          course['price'] as String,
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.accentCoral,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }

  Widget _buildSkeletonGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(4.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 2.h,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => _buildSkeletonCard(),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 2.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryDark,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    height: 1.5.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryDark,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 1.5.h,
                        width: 15.w,
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryDark,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Container(
                        height: 1.5.h,
                        width: 12.w,
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryDark,
                          borderRadius: BorderRadius.circular(4),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'search_off',
            color: AppTheme.textTertiary,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            'No courses found',
            style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Try adjusting your search or filters',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textTertiary,
            ),
          ),
          SizedBox(height: 3.h),
          ElevatedButton(
            onPressed: onRefresh,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentCoral,
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            ),
            child: Text(
              'Clear Filters',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return AppTheme.successTeal;
      case 'intermediate':
        return AppTheme.warningYellow;
      case 'advanced':
        return AppTheme.accentCoral;
      default:
        return AppTheme.textTertiary;
    }
  }

  void _showQuickActions(Map<String, dynamic> course) {
    // Quick actions implementation would go here
    // For now, just a placeholder
  }
}
