import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/course_bottom_bar.dart';
import './widgets/course_hero_section.dart';
import './widgets/course_tab_content.dart';

class CourseDetail extends StatefulWidget {
  const CourseDetail({Key? key}) : super(key: key);

  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  bool _isBookmarked = false;
  bool _showAppBarTitle = false;

  // Mock course data
  final Map<String, dynamic> courseData = {
    "id": 1,
    "title": "Complete Flutter Development Bootcamp",
    "description":
        """Master Flutter development from scratch with this comprehensive bootcamp. Learn to build beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. 

This course covers everything from basic Dart programming to advanced Flutter concepts including state management, animations, and deployment strategies. You'll work on real-world projects and build a portfolio of applications that showcase your skills.

Perfect for beginners with no prior mobile development experience, as well as experienced developers looking to add Flutter to their skillset.""",
    "instructor": "Sarah Johnson",
    "rating": 4.8,
    "students": 12547,
    "image":
        "https://images.unsplash.com/photo-1517077304055-6e89abbf09b0?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
    "duration": "12 weeks",
    "level": "Beginner to Advanced",
    "language": "English",
    "certificate": true,
    "isFree": false,
    "price": "\$89.99",
    "isEnrolled": false,
    "hasPreview": true,
    "progress": 0.0,
    "totalReviews": 2847,
    "learningOutcomes": [
      "Build complete Flutter applications from scratch",
      "Master Dart programming language fundamentals",
      "Implement responsive UI designs for multiple screen sizes",
      "Work with APIs and handle data persistence",
      "Deploy apps to Google Play Store and Apple App Store",
      "Understand state management patterns (Provider, Bloc, Riverpod)",
      "Create smooth animations and custom widgets",
      "Implement user authentication and security best practices"
    ],
    "prerequisites": [
      "Basic understanding of programming concepts",
      "Familiarity with object-oriented programming (helpful but not required)",
      "A computer with internet connection",
      "Willingness to learn and practice coding"
    ],
    "modules": [
      {
        "title": "Getting Started with Flutter",
        "duration": "3 hours",
        "lessons": [
          {
            "title": "Introduction to Flutter and Dart",
            "type": "video",
            "duration": "15 min",
            "completed": false
          },
          {
            "title": "Setting up Development Environment",
            "type": "video",
            "duration": "20 min",
            "completed": false
          },
          {
            "title": "Your First Flutter App",
            "type": "video",
            "duration": "25 min",
            "completed": false
          },
          {
            "title": "Understanding Widget Tree",
            "type": "article",
            "duration": "10 min",
            "completed": false
          }
        ]
      },
      {
        "title": "Dart Programming Fundamentals",
        "duration": "4 hours",
        "lessons": [
          {
            "title": "Variables and Data Types",
            "type": "video",
            "duration": "30 min",
            "completed": false
          },
          {
            "title": "Functions and Classes",
            "type": "video",
            "duration": "35 min",
            "completed": false
          },
          {
            "title": "Collections and Iterables",
            "type": "video",
            "duration": "25 min",
            "completed": false
          },
          {
            "title": "Asynchronous Programming",
            "type": "video",
            "duration": "40 min",
            "completed": false
          }
        ]
      },
      {
        "title": "Building User Interfaces",
        "duration": "6 hours",
        "lessons": [
          {
            "title": "Layout Widgets Deep Dive",
            "type": "video",
            "duration": "45 min",
            "completed": false
          },
          {
            "title": "Styling and Theming",
            "type": "video",
            "duration": "35 min",
            "completed": false
          },
          {
            "title": "Handling User Input",
            "type": "video",
            "duration": "30 min",
            "completed": false
          },
          {
            "title": "Navigation and Routing",
            "type": "video",
            "duration": "40 min",
            "completed": false
          },
          {
            "title": "Custom Widgets Creation",
            "type": "video",
            "duration": "50 min",
            "completed": false
          }
        ]
      }
    ],
    "reviews": [
      {
        "userName": "Michael Chen",
        "rating": 5,
        "date": "2 weeks ago",
        "comment":
            "Excellent course! Sarah explains everything clearly and the projects are really practical. I went from knowing nothing about Flutter to building my own apps. Highly recommended for anyone starting their mobile development journey."
      },
      {
        "userName": "Emily Rodriguez",
        "rating": 5,
        "date": "1 month ago",
        "comment":
            "This bootcamp exceeded my expectations. The curriculum is well-structured and the instructor provides great support. The real-world projects helped me build a solid portfolio. Already got my first Flutter developer job!"
      },
      {
        "userName": "David Kim",
        "rating": 4,
        "date": "3 weeks ago",
        "comment":
            "Great content and very comprehensive. Sometimes the pace felt a bit fast, but rewatching the videos helped. The community support is fantastic and the instructor is very responsive to questions."
      },
      {
        "userName": "Lisa Thompson",
        "rating": 5,
        "date": "1 week ago",
        "comment":
            "Best Flutter course I've taken! The hands-on approach and real projects make learning enjoyable. The deployment section was particularly helpful. Worth every penny!"
      }
    ]
  };

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final shouldShowTitle = offset > 200;

    if (shouldShowTitle != _showAppBarTitle) {
      setState(() {
        _showAppBarTitle = shouldShowTitle;
      });
    }
  }

  void _handleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });

    // Show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isBookmarked ? "Course bookmarked!" : "Bookmark removed",
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        backgroundColor: AppTheme.surfaceDialog,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _handleShare() {
    // Handle course sharing
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Share functionality would open native share sheet",
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        backgroundColor: AppTheme.surfaceDialog,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _handleEnroll() {
    final bool isEnrolled = courseData["isEnrolled"] as bool? ?? false;
    final bool isFree = courseData["isFree"] as bool? ?? false;

    if (isEnrolled) {
      // Navigate to course player
      Navigator.pushNamed(context, '/course-player');
    } else {
      // Handle enrollment process
      if (isFree) {
        _showEnrollmentSuccess();
      } else {
        _showPaymentDialog();
      }
    }
  }

  void _handlePreview() {
    // Show preview modal or navigate to preview
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDialog,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        height: 70.h,
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.borderColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 2.h),

            Text(
              "Course Preview",
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'play_circle_filled',
                        color: AppTheme.accentCoral,
                        size: 80,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Preview Video Player",
                        style:
                            AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "Sample lesson: Introduction to Flutter",
                        style:
                            AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 2.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Close Preview"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEnrollmentSuccess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDialog,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'check_circle',
              color: AppTheme.successTeal,
              size: 28,
            ),
            SizedBox(width: 3.w),
            Text(
              "Enrollment Successful!",
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          "Welcome to the course! You can now start learning and track your progress.",
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Continue Browsing"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/course-player');
            },
            child: Text("Start Learning"),
          ),
        ],
      ),
    );
  }

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDialog,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          "Complete Purchase",
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              courseData["title"] as String,
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Course Price:",
                  style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  courseData["price"] as String,
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.accentCoral,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Divider(color: AppTheme.borderColor),
            SizedBox(height: 1.h),
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'security',
                  color: AppTheme.successTeal,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    "Secure payment with 30-day money-back guarantee",
                    style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showEnrollmentSuccess();
            },
            child: Text("Purchase Now"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor:
            _showAppBarTitle ? AppTheme.primaryDark : Colors.transparent,
        elevation: _showAppBarTitle ? 1 : 0,
        leading: Container(
          margin: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryDark.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: CustomIconWidget(
              iconName: 'arrow_back',
              color: AppTheme.textPrimary,
              size: 24,
            ),
          ),
        ),
        title: _showAppBarTitle
            ? Text(
                courseData["title"] as String,
                style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        actions: [
          Container(
            margin: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryDark.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: _handleBookmark,
              icon: CustomIconWidget(
                iconName: _isBookmarked ? 'bookmark' : 'bookmark_border',
                color:
                    _isBookmarked ? AppTheme.accentCoral : AppTheme.textPrimary,
                size: 24,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 2.w, top: 2.w, bottom: 2.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryDark.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: _handleShare,
              icon: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.textPrimary,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Hero Section
                SliverToBoxAdapter(
                  child: CourseHeroSection(courseData: courseData),
                ),

                // Tab Content
                SliverFillRemaining(
                  child: CourseTabContent(courseData: courseData),
                ),
              ],
            ),
          ),

          // Bottom Action Bar
          CourseBottomBar(
            courseData: courseData,
            onEnrollPressed: _handleEnroll,
            onPreviewPressed: _handlePreview,
          ),
        ],
      ),
    );
  }
}
