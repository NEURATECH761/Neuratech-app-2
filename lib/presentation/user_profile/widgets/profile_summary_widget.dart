import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileSummaryWidget extends StatelessWidget {
  final String bio;
  final List<String> skills;
  final VoidCallback onEditBioPressed;

  const ProfileSummaryWidget({
    Key? key,
    required this.bio,
    required this.skills,
    required this.onEditBioPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'About',
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: onEditBioPressed,
                child: CustomIconWidget(
                  iconName: 'edit',
                  color: AppTheme.accentCoral,
                  size: 5.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.5.h),
          Text(
            bio,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Skills Earned',
            style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: skills.map((skill) => _buildSkillTag(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillTag(String skill) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
      decoration: BoxDecoration(
        color: AppTheme.accentCoral.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.accentCoral.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Text(
        skill,
        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
          color: AppTheme.accentCoral,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
