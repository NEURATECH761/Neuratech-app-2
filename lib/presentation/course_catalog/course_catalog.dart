import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/category_card_widget.dart';
import './widgets/course_grid_widget.dart';
import './widgets/filter_bottom_sheet_widget.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/search_header_widget.dart';

class CourseCatalog extends StatefulWidget {
  const CourseCatalog({Key? key}) : super(key: key);

  @override
  State<CourseCatalog> createState() => _CourseCatalogState();
}

class _CourseCatalogState extends State<CourseCatalog>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  Map<String, dynamic> _activeFilters = {};
  bool _isLoading = false;
  bool _showCategories = true;
  String _searchQuery = '';

  // Mock data for categories
  final List<Map<String, dynamic>> _categories = [
    {
      'id': 1,
      'name': 'Technology',
      'courseCount': 245,
      'image':
          'https://images.unsplash.com/photo-1518709268805-4e9042af2176?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
    },
    {
      'id': 2,
      'name': 'Business',
      'courseCount': 189,
      'image':
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
    },
    {
      'id': 3,
      'name': 'Creative Arts',
      'courseCount': 156,
      'image':
          'https://images.unsplash.com/photo-1513475382585-d06e58bcb0e0?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
    },
    {
      'id': 4,
      'name': 'Science',
      'courseCount': 134,
      'image':
          'https://images.unsplash.com/photo-1532094349884-543bc11b234d?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
    },
    {
      'id': 5,
      'name': 'Health & Fitness',
      'courseCount': 98,
      'image':
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
    },
    {
      'id': 6,
      'name': 'Language',
      'courseCount': 87,
      'image':
          'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
    },
  ];

  // Mock data for courses
  final List<Map<String, dynamic>> _allCourses = [
    {
      'id': 1,
      'title': 'Flutter Mobile Development',
      'instructor': 'Sarah Johnson',
      'category': 'Technology',
      'difficulty': 'Intermediate',
      'duration': '8 hours',
      'price': '\$89.99',
      'rating': 4.8,
      'image':
          'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
      'isBookmarked': false,
    },
    {
      'id': 2,
      'title': 'Digital Marketing Mastery',
      'instructor': 'Michael Chen',
      'category': 'Business',
      'difficulty': 'Beginner',
      'duration': '6 hours',
      'price': '\$69.99',
      'rating': 4.6,
      'image':
          'https://images.unsplash.com/photo-1460925895917-afdab827c52f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
      'isBookmarked': true,
    },
    {
      'id': 3,
      'title': 'UI/UX Design Fundamentals',
      'instructor': 'Emma Wilson',
      'category': 'Creative Arts',
      'difficulty': 'Beginner',
      'duration': '12 hours',
      'price': '\$99.99',
      'rating': 4.9,
      'image':
          'https://images.unsplash.com/photo-1561070791-2526d30994b5?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
      'isBookmarked': false,
    },
    {
      'id': 4,
      'title': 'Data Science with Python',
      'instructor': 'Dr. James Rodriguez',
      'category': 'Science',
      'difficulty': 'Advanced',
      'duration': '15 hours',
      'price': '\$129.99',
      'rating': 4.7,
      'image':
          'https://images.unsplash.com/photo-1551288049-bebda4e38f71?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
      'isBookmarked': false,
    },
    {
      'id': 5,
      'title': 'Photography Basics',
      'instructor': 'Lisa Anderson',
      'category': 'Creative Arts',
      'difficulty': 'Beginner',
      'duration': '4 hours',
      'price': 'Free',
      'rating': 4.5,
      'image':
          'https://images.unsplash.com/photo-1606983340126-99ab4feaa64a?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
      'isBookmarked': true,
    },
    {
      'id': 6,
      'title': 'Machine Learning Fundamentals',
      'instructor': 'Dr. Alex Kumar',
      'category': 'Technology',
      'difficulty': 'Intermediate',
      'duration': '10 hours',
      'price': '\$109.99',
      'rating': 4.8,
      'image':
          'https://images.unsplash.com/photo-1555949963-aa79dcee981c?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
      'isBookmarked': false,
    },
  ];

  List<Map<String, dynamic>> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filteredCourses = List.from(_allCourses);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _showCategories = _searchQuery.isEmpty;
      _filterCourses();
    });
  }

  void _filterCourses() {
    List<Map<String, dynamic>> filtered = List.from(_allCourses);

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((course) {
        final title = (course['title'] as String).toLowerCase();
        final instructor = (course['instructor'] as String).toLowerCase();
        final category = (course['category'] as String).toLowerCase();
        final query = _searchQuery.toLowerCase();

        return title.contains(query) ||
            instructor.contains(query) ||
            category.contains(query);
      }).toList();
    }

    // Apply other filters
    if (_activeFilters['difficulty'] != null) {
      filtered = filtered
          .where(
              (course) => course['difficulty'] == _activeFilters['difficulty'])
          .toList();
    }

    if (_activeFilters['price'] != null) {
      final priceFilter = _activeFilters['price'] as String;
      filtered = filtered.where((course) {
        final price = course['price'] as String;
        switch (priceFilter) {
          case 'Free':
            return price == 'Free';
          case '\$0-\$50':
            return price != 'Free' && _extractPrice(price) <= 50;
          case '\$50-\$100':
            return _extractPrice(price) > 50 && _extractPrice(price) <= 100;
          case '\$100+':
            return _extractPrice(price) > 100;
          default:
            return true;
        }
      }).toList();
    }

    if (_activeFilters['rating'] != null) {
      final minRating = _activeFilters['rating'] as double;
      filtered = filtered
          .where((course) => (course['rating'] as double) >= minRating)
          .toList();
    }

    setState(() {
      _filteredCourses = filtered;
    });
  }

  double _extractPrice(String priceString) {
    if (priceString == 'Free') return 0.0;
    final regex = RegExp(r'\d+\.?\d*');
    final match = regex.firstMatch(priceString);
    return match != null ? double.parse(match.group(0)!) : 0.0;
  }

  void _onCategoryTap(Map<String, dynamic> category) {
    setState(() {
      _searchController.text = category['name'] as String;
      _showCategories = false;
    });
  }

  void _onFilterTap() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FilterBottomSheetWidget(
          currentFilters: _activeFilters,
          onFiltersApplied: (filters) {
            setState(() {
              _activeFilters = filters;
              _filterCourses();
            });
          },
        ),
      ),
    );
  }

  void _onFilterRemoved(String filterKey) {
    setState(() {
      _activeFilters.remove(filterKey);
      _filterCourses();
    });
  }

  void _onRefresh() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _isLoading = false;
        _filteredCourses = List.from(_allCourses);
      });
    });
  }

  void _onCourseTap(Map<String, dynamic> course) {
    Navigator.pushNamed(context, '/course-detail', arguments: course);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkTheme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Search Header
          SearchHeaderWidget(
            searchController: _searchController,
            onSearchChanged: (query) {
              // Handled by listener
            },
            onFilterTap: _onFilterTap,
            activeFilterCount: _activeFilters.length,
          ),

          // Filter Chips
          FilterChipsWidget(
            activeFilters: _activeFilters,
            onFilterRemoved: _onFilterRemoved,
          ),

          // Tab Bar
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
              labelStyle: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle:
                  AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
              ),
              tabs: const [
                Tab(text: 'Categories'),
                Tab(text: 'All Courses'),
              ],
            ),
          ),

          SizedBox(height: 2.h),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Categories Tab
                _showCategories ? _buildCategoriesGrid() : _buildCoursesGrid(),
                // All Courses Tab
                _buildCoursesGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    return GridView.builder(
      padding: EdgeInsets.all(4.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 2.h,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        return CategoryCardWidget(
          category: _categories[index],
          onTap: () => _onCategoryTap(_categories[index]),
        );
      },
    );
  }

  Widget _buildCoursesGrid() {
    return CourseGridWidget(
      courses: _filteredCourses,
      isLoading: _isLoading,
      onRefresh: _onRefresh,
      onCourseTap: _onCourseTap,
    );
  }
}
