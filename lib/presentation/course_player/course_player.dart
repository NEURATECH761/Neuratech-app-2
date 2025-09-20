import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/lesson_navigation_widget.dart';
import './widgets/notes_panel_widget.dart';
import './widgets/transcript_panel_widget.dart';
import './widgets/video_player_widget.dart';

class CoursePlayer extends StatefulWidget {
  const CoursePlayer({Key? key}) : super(key: key);

  @override
  State<CoursePlayer> createState() => _CoursePlayerState();
}

class _CoursePlayerState extends State<CoursePlayer>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Duration _currentVideoPosition = Duration.zero;
  bool _showTranscript = false;
  bool _showNotes = false;
  bool _autoAdvance = true;

  // Mock data for current course and lesson
  final Map<String, dynamic> _currentCourse = {
    "id": 1,
    "title": "Advanced Flutter Development",
    "instructor": "Sarah Johnson",
    "totalLessons": 12,
    "completedLessons": 5,
    "progress": 0.42,
  };

  final List<Map<String, dynamic>> _lessons = [
    {
      "id": 1,
      "title": "Introduction to State Management",
      "description":
          "Learn the fundamentals of state management in Flutter applications and explore different approaches.",
      "duration": 25,
      "videoUrl": "https://example.com/video1.mp4",
      "completed": true,
    },
    {
      "id": 2,
      "title": "Provider Pattern Deep Dive",
      "description":
          "Master the Provider pattern for efficient state management across your Flutter app.",
      "duration": 32,
      "videoUrl": "https://example.com/video2.mp4",
      "completed": true,
    },
    {
      "id": 3,
      "title": "Bloc Architecture Implementation",
      "description":
          "Implement the BLoC pattern for scalable and testable Flutter applications.",
      "duration": 28,
      "videoUrl": "https://example.com/video3.mp4",
      "completed": false,
    },
    {
      "id": 4,
      "title": "Riverpod Advanced Techniques",
      "description":
          "Explore advanced Riverpod techniques for complex state management scenarios.",
      "duration": 35,
      "videoUrl": "https://example.com/video4.mp4",
      "completed": false,
    },
    {
      "id": 5,
      "title": "Performance Optimization",
      "description":
          "Optimize your Flutter app's performance with advanced state management techniques.",
      "duration": 30,
      "videoUrl": "https://example.com/video5.mp4",
      "completed": false,
    },
  ];

  Map<String, dynamic> _currentLesson = {};

  final List<Map<String, dynamic>> _transcriptSegments = [
    {
      "timestamp": "0:00",
      "text":
          "Welcome to this comprehensive lesson on state management in Flutter. Today we'll explore the fundamental concepts that every Flutter developer needs to understand.",
    },
    {
      "timestamp": "0:30",
      "text":
          "State management is crucial for building scalable and maintainable Flutter applications. It helps us manage data flow and user interface updates efficiently.",
    },
    {
      "timestamp": "1:15",
      "text":
          "Let's start by understanding what state means in the context of Flutter applications. State represents any data that can change over time.",
    },
    {
      "timestamp": "2:00",
      "text":
          "There are several approaches to state management in Flutter, including setState, Provider, BLoC, and Riverpod. Each has its own advantages and use cases.",
    },
    {
      "timestamp": "3:30",
      "text":
          "The Provider pattern is one of the most popular choices for state management. It provides a simple and efficient way to share data across widgets.",
    },
    {
      "timestamp": "5:00",
      "text":
          "Let's implement a practical example using the Provider pattern. We'll create a counter app that demonstrates the core concepts.",
    },
    {
      "timestamp": "7:45",
      "text":
          "Notice how the Provider pattern separates business logic from UI components, making our code more maintainable and testable.",
    },
    {
      "timestamp": "10:20",
      "text":
          "Now let's explore more advanced scenarios where we need to manage complex state across multiple screens and components.",
    },
  ];

  List<Map<String, dynamic>> _notes = [
    {
      "id": 1,
      "text":
          "Remember to always separate business logic from UI components for better maintainability.",
      "timestamp": 120,
      "createdAt": "2 hours ago",
    },
    {
      "id": 2,
      "text":
          "Provider pattern is great for small to medium apps. Consider BLoC for larger applications.",
      "timestamp": 300,
      "createdAt": "2 hours ago",
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _currentLesson = _lessons.first;

    // Set system UI overlay style for immersive experience
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  void _onVideoProgressChanged(Duration position) {
    setState(() {
      _currentVideoPosition = position;
    });
  }

  void _onVideoCompleted() {
    if (_autoAdvance) {
      _goToNextLesson();
    }
    HapticFeedback.mediumImpact();
  }

  void _onLessonChanged(Map<String, dynamic> lesson) {
    setState(() {
      _currentLesson = lesson;
      _currentVideoPosition = Duration.zero;
    });
  }

  void _onLessonCompleted(bool completed) {
    setState(() {
      _currentLesson['completed'] = completed;

      // Update the lesson in the main list
      final index =
          _lessons.indexWhere((lesson) => lesson['id'] == _currentLesson['id']);
      if (index != -1) {
        _lessons[index]['completed'] = completed;
      }
    });

    if (completed && _autoAdvance) {
      Future.delayed(const Duration(seconds: 2), () {
        _goToNextLesson();
      });
    }
  }

  void _goToNextLesson() {
    final currentIndex =
        _lessons.indexWhere((lesson) => lesson['id'] == _currentLesson['id']);
    if (currentIndex < _lessons.length - 1) {
      _onLessonChanged(_lessons[currentIndex + 1]);
    }
  }

  void _onSeekToTimestamp(Duration timestamp) {
    setState(() {
      _currentVideoPosition = timestamp;
    });
  }

  void _onAddNote(String text, Duration timestamp) {
    final newNote = {
      "id": _notes.length + 1,
      "text": text,
      "timestamp": timestamp.inSeconds,
      "createdAt": "Just now",
    };

    setState(() {
      _notes.add(newNote);
      _notes.sort(
          (a, b) => (a['timestamp'] as int).compareTo(b['timestamp'] as int));
    });
  }

  void _onDeleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  void _toggleAutoAdvance() {
    setState(() {
      _autoAdvance = !_autoAdvance;
    });
    HapticFeedback.lightImpact();
  }

  void _showSettingsBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: AppTheme.surfaceCard,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'settings',
                    color: AppTheme.textPrimary,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Player Settings',
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  children: [
                    // Auto-advance setting
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'skip_next',
                            color: AppTheme.textPrimary,
                            size: 24,
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Auto-advance to next lesson',
                                  style: AppTheme
                                      .darkTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Automatically play the next lesson when current one completes',
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: _autoAdvance,
                            onChanged: (value) {
                              _toggleAutoAdvance();
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 2.h),

                    // Download for offline viewing
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'download',
                            color: AppTheme.textPrimary,
                            size: 24,
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Download lesson',
                                  style: AppTheme
                                      .darkTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Download this lesson for offline viewing',
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomIconWidget(
                            iconName: 'arrow_forward_ios',
                            color: AppTheme.textSecondary,
                            size: 16,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 2.h),

                    // Report issue
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'report_problem',
                            color: AppTheme.textPrimary,
                            size: 24,
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Report an issue',
                                  style: AppTheme
                                      .darkTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    color: AppTheme.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Report playback issues or content problems',
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomIconWidget(
                            iconName: 'arrow_forward_ios',
                            color: AppTheme.textSecondary,
                            size: 16,
                          ),
                        ],
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

  void _showExitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDialog,
        title: Text(
          'Exit Lesson?',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: Text(
          'Your progress will be saved. Are you sure you want to exit this lesson?',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Continue Learning',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.accentCoral,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(
              'Exit',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmation();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppTheme.primaryDark,
        body: SafeArea(
          child: Column(
            children: [
              // Video player section
              VideoPlayerWidget(
                videoUrl: _currentLesson['videoUrl'] ?? '',
                videoTitle: _currentLesson['title'] ?? 'Untitled Lesson',
                videoDuration:
                    Duration(minutes: _currentLesson['duration'] ?? 0),
                onProgressChanged: _onVideoProgressChanged,
                onVideoCompleted: _onVideoCompleted,
              ),

              // Content section
              Expanded(
                child: Column(
                  children: [
                    // Lesson navigation
                    Padding(
                      padding: EdgeInsets.all(4.w),
                      child: LessonNavigationWidget(
                        currentLesson: _currentLesson,
                        lessons: _lessons,
                        onLessonChanged: _onLessonChanged,
                        onLessonCompleted: _onLessonCompleted,
                      ),
                    ),

                    // Tab bar for transcript and notes
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryDark,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: AppTheme.accentCoral,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelColor: AppTheme.textPrimary,
                        unselectedLabelColor: AppTheme.textSecondary,
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconWidget(
                                  iconName: 'subtitles',
                                  color: _tabController.index == 0
                                      ? AppTheme.textPrimary
                                      : AppTheme.textSecondary,
                                  size: 16,
                                ),
                                SizedBox(width: 2.w),
                                Text('Transcript'),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomIconWidget(
                                  iconName: 'note_add',
                                  color: _tabController.index == 1
                                      ? AppTheme.textPrimary
                                      : AppTheme.textSecondary,
                                  size: 16,
                                ),
                                SizedBox(width: 2.w),
                                Text('Notes'),
                                if (_notes.isNotEmpty) ...[
                                  SizedBox(width: 1.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 1.5.w, vertical: 0.2.h),
                                    decoration: BoxDecoration(
                                      color: AppTheme.accentCoral,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      '${_notes.length}',
                                      style: AppTheme
                                          .darkTheme.textTheme.labelSmall
                                          ?.copyWith(
                                        color: AppTheme.textPrimary,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 2.h),

                    // Tab bar view
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Transcript panel
                          TranscriptPanelWidget(
                            transcriptSegments: _transcriptSegments,
                            currentPosition: _currentVideoPosition,
                            onSeekToTimestamp: _onSeekToTimestamp,
                            isVisible: true,
                            onToggleVisibility: () {},
                          ),

                          // Notes panel
                          NotesPanelWidget(
                            notes: _notes,
                            currentPosition: _currentVideoPosition,
                            onAddNote: _onAddNote,
                            onDeleteNote: _onDeleteNote,
                            onSeekToTimestamp: _onSeekToTimestamp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Floating action button for settings
        floatingActionButton: FloatingActionButton(
          onPressed: _showSettingsBottomSheet,
          backgroundColor: AppTheme.accentCoral,
          child: CustomIconWidget(
            iconName: 'settings',
            color: AppTheme.textPrimary,
            size: 24,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }
}
