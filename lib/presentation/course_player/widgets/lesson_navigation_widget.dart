import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class LessonNavigationWidget extends StatefulWidget {
  final Map<String, dynamic> currentLesson;
  final List<Map<String, dynamic>> lessons;
  final Function(Map<String, dynamic>) onLessonChanged;
  final Function(bool) onLessonCompleted;

  const LessonNavigationWidget({
    Key? key,
    required this.currentLesson,
    required this.lessons,
    required this.onLessonChanged,
    required this.onLessonCompleted,
  }) : super(key: key);

  @override
  State<LessonNavigationWidget> createState() => _LessonNavigationWidgetState();
}

class _LessonNavigationWidgetState extends State<LessonNavigationWidget> {
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _isCompleted = widget.currentLesson['completed'] ?? false;
  }

  @override
  void didUpdateWidget(LessonNavigationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentLesson['id'] != widget.currentLesson['id']) {
      setState(() {
        _isCompleted = widget.currentLesson['completed'] ?? false;
      });
    }
  }

  int get _currentIndex {
    return widget.lessons
        .indexWhere((lesson) => lesson['id'] == widget.currentLesson['id']);
  }

  bool get _hasPrevious => _currentIndex > 0;
  bool get _hasNext => _currentIndex < widget.lessons.length - 1;

  void _goToPrevious() {
    if (_hasPrevious) {
      final previousLesson = widget.lessons[_currentIndex - 1];
      widget.onLessonChanged(previousLesson);
      HapticFeedback.lightImpact();
    }
  }

  void _goToNext() {
    if (_hasNext) {
      final nextLesson = widget.lessons[_currentIndex + 1];
      widget.onLessonChanged(nextLesson);
      HapticFeedback.lightImpact();
    }
  }

  void _toggleCompletion() {
    setState(() {
      _isCompleted = !_isCompleted;
    });
    widget.onLessonCompleted(_isCompleted);
    HapticFeedback.mediumImpact();
  }

  String _formatDuration(int minutes) {
    if (minutes < 60) {
      return '${minutes}m';
    }
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return remainingMinutes > 0
        ? '${hours}h ${remainingMinutes}m'
        : '${hours}h';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lesson progress indicator
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.accentCoral.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Lesson ${_currentIndex + 1} of ${widget.lessons.length}',
                  style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                    color: AppTheme.accentCoral,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.successTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'access_time',
                      color: AppTheme.successTeal,
                      size: 14,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      _formatDuration(widget.currentLesson['duration'] ?? 0),
                      style: AppTheme.darkTheme.textTheme.labelMedium?.copyWith(
                        color: AppTheme.successTeal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Current lesson info
          Text(
            widget.currentLesson['title'] ?? 'Untitled Lesson',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          if (widget.currentLesson['description'] != null) ...[
            SizedBox(height: 1.h),
            Text(
              widget.currentLesson['description'],
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],

          SizedBox(height: 3.h),

          // Completion checkbox
          GestureDetector(
            onTap: _toggleCompletion,
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: _isCompleted
                    ? AppTheme.successTeal.withValues(alpha: 0.1)
                    : AppTheme.borderColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isCompleted
                      ? AppTheme.successTeal
                      : AppTheme.borderColor,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 6.w,
                    height: 6.w,
                    decoration: BoxDecoration(
                      color: _isCompleted
                          ? AppTheme.successTeal
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: _isCompleted
                            ? AppTheme.successTeal
                            : AppTheme.borderColor,
                        width: 2,
                      ),
                    ),
                    child: _isCompleted
                        ? CustomIconWidget(
                            iconName: 'check',
                            color: AppTheme.textPrimary,
                            size: 16,
                          )
                        : null,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      _isCompleted ? 'Lesson completed!' : 'Mark as completed',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        color: _isCompleted
                            ? AppTheme.successTeal
                            : AppTheme.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (_isCompleted)
                    CustomIconWidget(
                      iconName: 'celebration',
                      color: AppTheme.successTeal,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Navigation buttons
          Row(
            children: [
              // Previous button
              Expanded(
                child: ElevatedButton(
                  onPressed: _hasPrevious ? _goToPrevious : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasPrevious
                        ? AppTheme.secondaryDark
                        : AppTheme.textTertiary.withValues(alpha: 0.2),
                    foregroundColor: _hasPrevious
                        ? AppTheme.textPrimary
                        : AppTheme.textTertiary,
                    elevation: _hasPrevious ? 2 : 0,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'arrow_back_ios',
                        color: _hasPrevious
                            ? AppTheme.textPrimary
                            : AppTheme.textTertiary,
                        size: 16,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Previous',
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 4.w),

              // Next button
              Expanded(
                child: ElevatedButton(
                  onPressed: _hasNext ? _goToNext : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasNext
                        ? AppTheme.accentCoral
                        : AppTheme.textTertiary.withValues(alpha: 0.2),
                    foregroundColor: AppTheme.textPrimary,
                    elevation: _hasNext ? 2 : 0,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _hasNext ? 'Next' : 'Completed',
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      CustomIconWidget(
                        iconName:
                            _hasNext ? 'arrow_forward_ios' : 'check_circle',
                        color: AppTheme.textPrimary,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (!_hasNext && _isCompleted) ...[
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.successTeal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.successTeal,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'emoji_events',
                    color: AppTheme.successTeal,
                    size: 24,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Congratulations!',
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.successTeal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'You\'ve completed all lessons in this module.',
                          style:
                              AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
