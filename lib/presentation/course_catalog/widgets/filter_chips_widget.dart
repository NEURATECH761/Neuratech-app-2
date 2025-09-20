import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterChipsWidget extends StatelessWidget {
  final Map<String, dynamic> activeFilters;
  final Function(String) onFilterRemoved;

  const FilterChipsWidget({
    Key? key,
    required this.activeFilters,
    required this.onFilterRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (activeFilters.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Wrap(
        spacing: 2.w,
        runSpacing: 1.h,
        children: activeFilters.entries.map((entry) {
          return _buildFilterChip(entry.key, entry.value);
        }).toList(),
      ),
    );
  }

  Widget _buildFilterChip(String key, dynamic value) {
    String displayText = '';

    switch (key) {
      case 'difficulty':
        displayText = value.toString();
        break;
      case 'duration':
        displayText = value.toString();
        break;
      case 'price':
        displayText = value.toString();
        break;
      case 'rating':
        displayText = '${value}+ ⭐';
        break;
      default:
        displayText = value.toString();
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.accentCoral.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.accentCoral,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            displayText,
            style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.accentCoral,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: 2.w),
          GestureDetector(
            onTap: () => onFilterRemoved(key),
            child: CustomIconWidget(
              iconName: 'close',
              color: AppTheme.accentCoral,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
