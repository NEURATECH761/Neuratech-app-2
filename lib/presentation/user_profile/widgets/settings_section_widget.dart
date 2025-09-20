import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SettingsSectionWidget extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;

  const SettingsSectionWidget({
    Key? key,
    required this.title,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Text(
              title,
              style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Column(
              children: [
                if (index > 0)
                  Divider(
                    color: AppTheme.borderColor,
                    thickness: 1,
                    height: 1,
                  ),
                _buildSettingsItem(item),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(SettingsItem item) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      leading: item.icon != null
          ? CustomIconWidget(
              iconName: item.icon!,
              color: AppTheme.textSecondary,
              size: 6.w,
            )
          : null,
      title: Text(
        item.title,
        style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.textPrimary,
        ),
      ),
      subtitle: item.subtitle != null
          ? Text(
              item.subtitle!,
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
              ),
            )
          : null,
      trailing: item.trailing ??
          CustomIconWidget(
            iconName: 'chevron_right',
            color: AppTheme.textTertiary,
            size: 5.w,
          ),
      onTap: item.onTap,
    );
  }
}

class SettingsItem {
  final String title;
  final String? subtitle;
  final String? icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  SettingsItem({
    required this.title,
    this.subtitle,
    this.icon,
    this.trailing,
    this.onTap,
  });
}
