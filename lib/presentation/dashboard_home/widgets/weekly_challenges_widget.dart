import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WeeklyChallengesWidget extends StatelessWidget {
  const WeeklyChallengesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> challenges = [
      {
        "id": 1,
        "title": "Code 30 Minutes Daily",
        "description":
            "Practice coding for at least 30 minutes every day this week",
        "progress": 0.57,
        "currentStreak": 4,
        "targetDays": 7,
        "reward": "50 XP + Badge",
        "icon": "code",
        "color": AppTheme.accentCoral,
        "daysCompleted": [true, true, false, true, true, false, false],
      },
      {
        "id": 2,
        "title": "Complete 3 Quizzes",
        "description": "Test your knowledge by completing 3 course quizzes",
        "progress": 0.67,
        "currentCount": 2,
        "targetCount": 3,
        "reward": "30 XP + Certificate",
        "icon": "quiz",
        "color": AppTheme.successTeal,
        "daysCompleted": [],
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
                    'Weekly Challenges',
                    style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    'Boost your learning with fun challenges',
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.warningYellow.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'local_fire_department',
                      color: AppTheme.warningYellow,
                      size: 16,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      '4 day streak',
                      style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                        color: AppTheme.warningYellow,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 22.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            itemCount: challenges.length,
            itemBuilder: (context, index) {
              final challenge = challenges[index];
              return _buildChallengeCard(context, challenge);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeCard(
      BuildContext context, Map<String, dynamic> challenge) {
    return Container(
      width: 80.w,
      margin: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
        border: Border.all(
          color: (challenge["color"] as Color).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: (challenge["color"] as Color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: CustomIconWidget(
                    iconName: challenge["icon"] as String,
                    color: challenge["color"] as Color,
                    size: 24,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge["title"] as String,
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        challenge["description"] as String,
                        style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            if (challenge["daysCompleted"] != null &&
                (challenge["daysCompleted"] as List).isNotEmpty)
              _buildDailyProgress(challenge)
            else
              _buildCountProgress(challenge),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: AppTheme.warningYellow.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'emoji_events',
                        color: AppTheme.warningYellow,
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        challenge["reward"] as String,
                        style:
                            AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.warningYellow,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${((challenge["progress"] as double) * 100).toInt()}% Complete',
                  style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                    color: challenge["color"] as Color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyProgress(Map<String, dynamic> challenge) {
    final daysCompleted = challenge["daysCompleted"] as List<bool>;
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Progress',
          style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (index) {
            final isCompleted =
                index < daysCompleted.length ? daysCompleted[index] : false;
            final isToday = index == DateTime.now().weekday - 1;

            return Container(
              width: 8.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isCompleted
                    ? challenge["color"] as Color
                    : isToday
                        ? (challenge["color"] as Color).withValues(alpha: 0.3)
                        : AppTheme.borderColor,
                borderRadius: BorderRadius.circular(8),
                border: isToday
                    ? Border.all(
                        color: challenge["color"] as Color,
                        width: 2,
                      )
                    : null,
              ),
              child: Center(
                child: isCompleted
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.textPrimary,
                        size: 16,
                      )
                    : Text(
                        days[index],
                        style:
                            AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                          color: isToday
                              ? challenge["color"] as Color
                              : AppTheme.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCountProgress(Map<String, dynamic> challenge) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
            Text(
              '${challenge["currentCount"]}/${challenge["targetCount"]}',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: challenge["color"] as Color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        LinearProgressIndicator(
          value: challenge["progress"] as double,
          backgroundColor: AppTheme.borderColor,
          valueColor:
              AlwaysStoppedAnimation<Color>(challenge["color"] as Color),
          minHeight: 6,
        ),
      ],
    );
  }
}
