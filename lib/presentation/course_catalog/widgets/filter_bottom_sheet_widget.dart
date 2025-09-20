import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final Map<String, dynamic> currentFilters;
  final Function(Map<String, dynamic>) onFiltersApplied;

  const FilterBottomSheetWidget({
    Key? key,
    required this.currentFilters,
    required this.onFiltersApplied,
  }) : super(key: key);

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  late Map<String, dynamic> _filters;

  final List<String> _difficultyLevels = [
    'Beginner',
    'Intermediate',
    'Advanced'
  ];
  final List<String> _durations = [
    '0-2 hours',
    '2-5 hours',
    '5-10 hours',
    '10+ hours'
  ];
  final List<String> _priceRanges = [
    'Free',
    '\$0-\$50',
    '\$50-\$100',
    '\$100+'
  ];
  final List<double> _ratings = [4.5, 4.0, 3.5, 3.0];

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.dialogBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle Bar
          Container(
            margin: EdgeInsets.only(top: 1.h),
            width: 10.w,
            height: 0.5.h,
            decoration: BoxDecoration(
              color: AppTheme.textTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: AppTheme.darkTheme.textTheme.headlineSmall?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: _clearFilters,
                  child: Text(
                    'Clear All',
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.accentCoral,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Filter Content
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                children: [
                  _buildFilterSection(
                      'Difficulty Level', _difficultyLevels, 'difficulty'),
                  _buildFilterSection('Duration', _durations, 'duration'),
                  _buildFilterSection('Price Range', _priceRanges, 'price'),
                  _buildRatingSection(),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
          // Apply Button
          Container(
            padding: EdgeInsets.all(4.w),
            child: SizedBox(
              width: double.infinity,
              height: 6.h,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentCoral,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Apply Filters',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(
      String title, List<String> options, String filterKey) {
    return ExpansionTile(
      title: Text(
        title,
        style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconColor: AppTheme.textSecondary,
      collapsedIconColor: AppTheme.textSecondary,
      children: options.map((option) {
        final isSelected = _filters[filterKey] == option;
        return ListTile(
          title: Text(
            option,
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: isSelected ? AppTheme.accentCoral : AppTheme.textSecondary,
            ),
          ),
          trailing: isSelected
              ? CustomIconWidget(
                  iconName: 'check',
                  color: AppTheme.accentCoral,
                  size: 20,
                )
              : null,
          onTap: () {
            setState(() {
              _filters[filterKey] = isSelected ? null : option;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRatingSection() {
    return ExpansionTile(
      title: Text(
        'Minimum Rating',
        style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
          color: AppTheme.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconColor: AppTheme.textSecondary,
      collapsedIconColor: AppTheme.textSecondary,
      children: _ratings.map((rating) {
        final isSelected = _filters['rating'] == rating;
        return ListTile(
          title: Row(
            children: [
              Text(
                rating.toString(),
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? AppTheme.accentCoral
                      : AppTheme.textSecondary,
                ),
              ),
              SizedBox(width: 2.w),
              CustomIconWidget(
                iconName: 'star',
                color: AppTheme.warningYellow,
                size: 16,
              ),
              Text(
                ' & up',
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: isSelected
                      ? AppTheme.accentCoral
                      : AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          trailing: isSelected
              ? CustomIconWidget(
                  iconName: 'check',
                  color: AppTheme.accentCoral,
                  size: 20,
                )
              : null,
          onTap: () {
            setState(() {
              _filters['rating'] = isSelected ? null : rating;
            });
          },
        );
      }).toList(),
    );
  }

  void _clearFilters() {
    setState(() {
      _filters.clear();
    });
  }

  void _applyFilters() {
    widget.onFiltersApplied(_filters);
    Navigator.pop(context);
  }
}
