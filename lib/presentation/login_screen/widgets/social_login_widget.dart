import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SocialLoginWidget extends StatelessWidget {
  final bool isLoading;
  final Function() onGoogleLogin;
  final Function() onAppleLogin;

  const SocialLoginWidget({
    Key? key,
    required this.isLoading,
    required this.onGoogleLogin,
    required this.onAppleLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with "OR" text
        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppTheme.borderColor,
                thickness: 1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                'OR',
                style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textTertiary,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: AppTheme.borderColor,
                thickness: 1,
              ),
            ),
          ],
        ),

        SizedBox(height: 3.h),

        // Social Login Buttons
        Column(
          children: [
            // Google Login Button
            SizedBox(
              height: 6.h,
              width: double.infinity,
              child: OutlinedButton(
                onPressed: isLoading ? null : onGoogleLogin,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: AppTheme.borderColor,
                    width: 1.5,
                  ),
                  backgroundColor: AppTheme.surfaceCard,
                  foregroundColor: AppTheme.textPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImageWidget(
                      imageUrl:
                          'https://developers.google.com/identity/images/g-logo.png',
                      width: 5.w,
                      height: 5.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'Continue with Google',
                      style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 2.h),

            // Apple Login Button (iOS only)
            if (defaultTargetPlatform == TargetPlatform.iOS || kIsWeb)
              SizedBox(
                height: 6.h,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: isLoading ? null : onAppleLogin,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppTheme.borderColor,
                      width: 1.5,
                    ),
                    backgroundColor: AppTheme.surfaceCard,
                    foregroundColor: AppTheme.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'apple',
                        color: AppTheme.textPrimary,
                        size: 5.w,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'Continue with Apple',
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
