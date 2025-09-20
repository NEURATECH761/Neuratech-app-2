import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchHeaderWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final VoidCallback onFilterTap;
  final int activeFilterCount;

  const SearchHeaderWidget({
    Key? key,
    required this.searchController,
    required this.onSearchChanged,
    required this.onFilterTap,
    required this.activeFilterCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowColor,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Search Bar
            Expanded(
              child: Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: AppTheme.secondaryDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.borderColor,
                    width: 1,
                  ),
                ),
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search courses...',
                    hintStyle:
                        AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textTertiary,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: CustomIconWidget(
                        iconName: 'search',
                        color: AppTheme.textSecondary,
                        size: 20,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4.w,
                      vertical: 2.h,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 3.w),
            // Filter Button
            GestureDetector(
              onTap: onFilterTap,
              child: Container(
                height: 6.h,
                width: 6.h,
                decoration: BoxDecoration(
                  color: AppTheme.secondaryDark,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.borderColor,
                    width: 1,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: CustomIconWidget(
                        iconName: 'tune',
                        color: AppTheme.textPrimary,
                        size: 24,
                      ),
                    ),
                    if (activeFilterCount > 0)
                      Positioned(
                        top: 1.h,
                        right: 1.h,
                        child: Container(
                          padding: EdgeInsets.all(0.5.w),
                          decoration: BoxDecoration(
                            color: AppTheme.accentCoral,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 2.h,
                            minHeight: 2.h,
                          ),
                          child: Text(
                            activeFilterCount.toString(),
                            style: AppTheme.darkTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.textPrimary,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
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
}
