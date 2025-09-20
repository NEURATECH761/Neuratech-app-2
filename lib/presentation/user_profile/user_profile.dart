import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/camera_modal_widget.dart';
import './widgets/profile_header_widget.dart';
import './widgets/profile_summary_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/statistics_cards_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // Mock user data
  final Map<String, dynamic> userData = {
    "id": 1,
    "fullName": "Sarah Johnson",
    "email": "sarah.johnson@email.com",
    "location": "San Francisco, CA",
    "joinDate": "March 2023",
    "profileImage":
        "https://images.unsplash.com/photo-1494790108755-2616b612b786?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
    "bio":
        "Passionate learner and tech enthusiast with 5+ years of experience in software development. Always eager to explore new technologies and share knowledge with the community.",
    "coursesCompleted": 24,
    "followers": 156,
    "following": 89,
    "skills": [
      "Flutter",
      "Dart",
      "JavaScript",
      "Python",
      "UI/UX Design",
      "Machine Learning",
      "Cloud Computing",
      "Agile Development"
    ],
    "phone": "+1 (555) 123-4567",
    "currentPlan": "Premium",
    "billingCycle": "Monthly",
    "nextBilling": "October 15, 2024",
    "darkTheme": true,
    "notifications": {
      "courseReminders": true,
      "achievements": true,
      "marketing": false,
    }
  };

  String _currentProfileImage = "";

  @override
  void initState() {
    super.initState();
    _currentProfileImage = userData["profileImage"] as String;
  }

  void _showCameraModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CameraModalWidget(
        onImageSelected: (XFile image) {
          setState(() {
            _currentProfileImage = image.path;
          });
        },
      ),
    );
  }

  void _showEditProfileModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDialog,
        title: Text(
          'Edit Profile',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Full Name',
                hintText: userData["fullName"],
              ),
            ),
            SizedBox(height: 2.h),
            TextField(
              decoration: InputDecoration(
                labelText: 'Location',
                hintText: userData["location"],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profile updated successfully!')),
              );
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showBioEditModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDialog,
        title: Text(
          'Edit Bio',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: TextField(
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Bio',
            hintText: userData["bio"],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bio updated successfully!')),
              );
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDialog,
        title: Text(
          'Sign Out',
          style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          'Are you sure you want to sign out?',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login-screen',
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorSoft,
            ),
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _navigateToDetailScreen(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title details coming soon!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeaderWidget(
                profileImageUrl: _currentProfileImage,
                fullName: userData["fullName"] as String,
                location: userData["location"] as String,
                joinDate: userData["joinDate"] as String,
                onEditProfilePressed: _showEditProfileModal,
                onCameraPressed: _showCameraModal,
              ),
              SizedBox(height: 2.h),
              StatisticsCardsWidget(
                coursesCompleted: userData["coursesCompleted"] as int,
                followers: userData["followers"] as int,
                following: userData["following"] as int,
                onCoursesPressed: () => _navigateToDetailScreen('Courses'),
                onFollowersPressed: () => _navigateToDetailScreen('Followers'),
                onFollowingPressed: () => _navigateToDetailScreen('Following'),
              ),
              SizedBox(height: 2.h),
              ProfileSummaryWidget(
                bio: userData["bio"] as String,
                skills: (userData["skills"] as List).cast<String>(),
                onEditBioPressed: _showBioEditModal,
              ),
              SettingsSectionWidget(
                title: 'Personal Information',
                items: [
                  SettingsItem(
                    title: 'Name',
                    subtitle: userData["fullName"] as String,
                    icon: 'person',
                    onTap: () => _navigateToDetailScreen('Edit Name'),
                  ),
                  SettingsItem(
                    title: 'Email',
                    subtitle: userData["email"] as String,
                    icon: 'email',
                    onTap: () => _navigateToDetailScreen('Edit Email'),
                  ),
                  SettingsItem(
                    title: 'Phone',
                    subtitle: userData["phone"] as String,
                    icon: 'phone',
                    onTap: () => _navigateToDetailScreen('Edit Phone'),
                  ),
                ],
              ),
              SettingsSectionWidget(
                title: 'Security',
                items: [
                  SettingsItem(
                    title: 'Change Password',
                    subtitle: 'Update your password',
                    icon: 'lock',
                    onTap: () => _navigateToDetailScreen('Change Password'),
                  ),
                  SettingsItem(
                    title: 'Biometric Settings',
                    subtitle: 'Face ID & Fingerprint',
                    icon: 'fingerprint',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Biometric ${value ? 'enabled' : 'disabled'}')),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SettingsSectionWidget(
                title: 'Notifications',
                items: [
                  SettingsItem(
                    title: 'Course Reminders',
                    subtitle: 'Get notified about your courses',
                    icon: 'notifications',
                    trailing: Switch(
                      value: (userData["notifications"]
                          as Map)["courseReminders"] as bool,
                      onChanged: (value) {
                        setState(() {
                          (userData["notifications"]
                              as Map)["courseReminders"] = value;
                        });
                      },
                    ),
                  ),
                  SettingsItem(
                    title: 'Achievements',
                    subtitle: 'Celebrate your progress',
                    icon: 'emoji_events',
                    trailing: Switch(
                      value: (userData["notifications"] as Map)["achievements"]
                          as bool,
                      onChanged: (value) {
                        setState(() {
                          (userData["notifications"] as Map)["achievements"] =
                              value;
                        });
                      },
                    ),
                  ),
                  SettingsItem(
                    title: 'Marketing',
                    subtitle: 'Promotional content',
                    icon: 'campaign',
                    trailing: Switch(
                      value: (userData["notifications"] as Map)["marketing"]
                          as bool,
                      onChanged: (value) {
                        setState(() {
                          (userData["notifications"] as Map)["marketing"] =
                              value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SettingsSectionWidget(
                title: 'Subscription',
                items: [
                  SettingsItem(
                    title: 'Current Plan',
                    subtitle:
                        '${userData["currentPlan"]} - ${userData["billingCycle"]}',
                    icon: 'card_membership',
                    onTap: () =>
                        _navigateToDetailScreen('Subscription Details'),
                  ),
                  SettingsItem(
                    title: 'Billing History',
                    subtitle: 'View past payments',
                    icon: 'receipt',
                    onTap: () => _navigateToDetailScreen('Billing History'),
                  ),
                  SettingsItem(
                    title: 'Upgrade Plan',
                    subtitle: 'Get more features',
                    icon: 'upgrade',
                    onTap: () => _navigateToDetailScreen('Upgrade Plan'),
                  ),
                ],
              ),
              SettingsSectionWidget(
                title: 'Preferences',
                items: [
                  SettingsItem(
                    title: 'Dark Theme',
                    subtitle: 'Use dark mode',
                    icon: 'dark_mode',
                    trailing: Switch(
                      value: userData["darkTheme"] as bool,
                      onChanged: (value) {
                        setState(() {
                          userData["darkTheme"] = value;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Theme ${value ? 'dark' : 'light'} mode enabled')),
                        );
                      },
                    ),
                  ),
                  SettingsItem(
                    title: 'Privacy Settings',
                    subtitle: 'Control your data',
                    icon: 'privacy_tip',
                    onTap: () => _navigateToDetailScreen('Privacy Settings'),
                  ),
                ],
              ),
              SettingsSectionWidget(
                title: 'Support',
                items: [
                  SettingsItem(
                    title: 'Help Center',
                    subtitle: 'Get help and support',
                    icon: 'help',
                    onTap: () => _navigateToDetailScreen('Help Center'),
                  ),
                  SettingsItem(
                    title: 'Contact Us',
                    subtitle: 'Reach out to our team',
                    icon: 'contact_support',
                    onTap: () => _navigateToDetailScreen('Contact Us'),
                  ),
                  SettingsItem(
                    title: 'App Version',
                    subtitle: 'v1.0.0 (Build 100)',
                    icon: 'info',
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _showSignOutDialog,
                  icon: CustomIconWidget(
                    iconName: 'logout',
                    color: AppTheme.textPrimary,
                    size: 5.w,
                  ),
                  label: Text('Sign Out'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.errorSoft,
                    foregroundColor: AppTheme.textPrimary,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ),
    );
  }
}
