import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class StatisticsCardsWidget extends StatelessWidget {
  final int coursesCompleted;
  final int followers;
  final int following;
  final VoidCallback onCoursesPressed;
  final VoidCallback onFollowersPressed;
  final VoidCallback onFollowingPressed;

  const StatisticsCardsWidget({
    Key? key,
    required this.coursesCompleted,
    required this.followers,
    required this.following,
    required this.onCoursesPressed,
    required this.onFollowersPressed,
    required this.onFollowingPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              title: 'Courses',
              value: coursesCompleted.toString(),
              onTap: onCoursesPressed,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: _buildStatCard(
              title: 'Followers',
              value: followers.toString(),
              onTap: onFollowersPressed,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: _buildStatCard(
              title: 'Following',
              value: following.toString(),
              onTap: onFollowingPressed,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTheme.dataTextTheme.bodyLarge?.copyWith(
                color: AppTheme.accentCoral,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 0.5.h),
            Text(
              title,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
