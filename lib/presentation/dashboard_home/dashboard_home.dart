import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/bottom_navigation_widget.dart';
import './widgets/continue_learning_widget.dart';
import './widgets/new_courses_widget.dart';
import './widgets/recommended_courses_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/weekly_challenges_widget.dart';
import './widgets/welcome_header_widget.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({Key? key}) : super(key: key);

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  int _currentNavIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isRefreshing = false;

  // Mock user data
  final Map<String, dynamic> userData = {
    "id": 1,
    "name": "Alex Johnson",
    "email": "alex.johnson@email.com",
    "profileImage":
        "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?fm=jpg&q=60&w=400&ixlib=rb-4.0.3",
    "joinedDate": "2023-08-15",
    "totalCourses": 12,
    "completedCourses": 8,
    "hoursLearned": 156,
    "skillsAchieved": 24,
    "currentStreak": 4,
    "preferences": ["Technology", "Design", "Business"],
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Handle scroll events for potential future features
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Load more content if needed
    }
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isRefreshing = false;
    });

    // Show refresh feedback
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Content refreshed successfully!',
            style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          backgroundColor: AppTheme.surfaceDialog,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _handleSearch(String query) {
    if (query.isNotEmpty) {
      // Navigate to course catalog with search query
      Navigator.pushNamed(context, '/course-catalog');
    }
  }

  void _handleSearchTap() {
    // Navigate to course catalog for search
    Navigator.pushNamed(context, '/course-catalog');
  }

  void _onNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppTheme.accentCoral,
          backgroundColor: AppTheme.surfaceDialog,
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              // Welcome Header
              SliverToBoxAdapter(
                child: WelcomeHeaderWidget(
                  userName: userData["name"] as String,
                ),
              ),

              // Search Bar
              SliverToBoxAdapter(
                child: SearchBarWidget(
                  onTap: _handleSearchTap,
                  onChanged: _handleSearch,
                ),
              ),

              // Continue Learning Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: const ContinueLearningWidget(),
                ),
              ),

              // Weekly Challenges Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: const WeeklyChallengesWidget(),
                ),
              ),

              // New Courses Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: const NewCoursesWidget(),
                ),
              ),

              // Recommended Courses Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 3.h),
                  child: const RecommendedCoursesWidget(),
                ),
              ),

              // Bottom spacing for navigation
              SliverToBoxAdapter(
                child: SizedBox(height: 10.h),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationWidget(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSearchTap,
        backgroundColor: AppTheme.accentCoral,
        child: CustomIconWidget(
          iconName: 'search',
          color: AppTheme.textPrimary,
          size: 24,
        ),
      ),
    );
  }
}
