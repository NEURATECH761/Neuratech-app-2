import 'package:flutter/material.dart';
import '../presentation/course_player/course_player.dart';
import '../presentation/user_profile/user_profile.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/course_detail/course_detail.dart';
import '../presentation/course_catalog/course_catalog.dart';
import '../presentation/dashboard_home/dashboard_home.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String coursePlayer = '/course-player';
  static const String userProfile = '/user-profile';
  static const String login = '/login-screen';
  static const String courseDetail = '/course-detail';
  static const String courseCatalog = '/course-catalog';
  static const String dashboardHome = '/dashboard-home';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const LoginScreen(),
    coursePlayer: (context) => const CoursePlayer(),
    userProfile: (context) => const UserProfile(),
    login: (context) => const LoginScreen(),
    courseDetail: (context) => const CourseDetail(),
    courseCatalog: (context) => const CourseCatalog(),
    dashboardHome: (context) => const DashboardHome(),
    // TODO: Add your other routes here
  };
}
