import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TranscriptPanelWidget extends StatefulWidget {
  final List<Map<String, dynamic>> transcriptSegments;
  final Duration currentPosition;
  final Function(Duration) onSeekToTimestamp;
  final bool isVisible;
  final VoidCallback onToggleVisibility;

  const TranscriptPanelWidget({
    Key? key,
    required this.transcriptSegments,
    required this.currentPosition,
    required this.onSeekToTimestamp,
    required this.isVisible,
    required this.onToggleVisibility,
  }) : super(key: key);

  @override
  State<TranscriptPanelWidget> createState() => _TranscriptPanelWidgetState();
}

class _TranscriptPanelWidgetState extends State<TranscriptPanelWidget> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';
  int? _activeSegmentIndex;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void didUpdateWidget(TranscriptPanelWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPosition != widget.currentPosition) {
      _updateActiveSegment();
    }
  }

  void _updateActiveSegment() {
    final currentSeconds = widget.currentPosition.inSeconds;

    for (int i = 0; i < widget.transcriptSegments.length; i++) {
      final segment = widget.transcriptSegments[i];
      final startTime = _parseTimestamp(segment['timestamp']);
      final endTime = i < widget.transcriptSegments.length - 1
          ? _parseTimestamp(widget.transcriptSegments[i + 1]['timestamp'])
          : startTime + 10; // Default 10 seconds for last segment

      if (currentSeconds >= startTime && currentSeconds < endTime) {
        if (_activeSegmentIndex != i) {
          setState(() {
            _activeSegmentIndex = i;
          });
          _scrollToActiveSegment(i);
        }
        break;
      }
    }
  }

  void _scrollToActiveSegment(int index) {
    if (_scrollController.hasClients) {
      final itemHeight = 15.h; // Approximate height of each segment
      final targetOffset = index * itemHeight;

      _scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  int _parseTimestamp(String timestamp) {
    final parts = timestamp.split(':');
    if (parts.length == 2) {
      final minutes = int.tryParse(parts[0]) ?? 0;
      final seconds = int.tryParse(parts[1]) ?? 0;
      return minutes * 60 + seconds;
    } else if (parts.length == 3) {
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      final seconds = int.tryParse(parts[2]) ?? 0;
      return hours * 3600 + minutes * 60 + seconds;
    }
    return 0;
  }

  Duration _timestampToDuration(String timestamp) {
    final seconds = _parseTimestamp(timestamp);
    return Duration(seconds: seconds);
  }

  List<Map<String, dynamic>> get _filteredSegments {
    if (_searchQuery.isEmpty) {
      return widget.transcriptSegments;
    }

    return widget.transcriptSegments.where((segment) {
      final text = (segment['text'] as String).toLowerCase();
      return text.contains(_searchQuery);
    }).toList();
  }

  Widget _buildHighlightedText(String text, String query) {
    if (query.isEmpty) {
      return Text(
        text,
        style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.textPrimary,
          height: 1.5,
        ),
      );
    }

    final lowerText = text.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];

    int start = 0;
    int index = lowerText.indexOf(lowerQuery, start);

    while (index != -1) {
      // Add text before the match
      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ));
      }

      // Add the highlighted match
      spans.add(TextSpan(
        text: text.substring(index, index + query.length),
        style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.accentCoral,
          backgroundColor: AppTheme.accentCoral.withValues(alpha: 0.2),
          fontWeight: FontWeight.w600,
        ),
      ));

      start = index + query.length;
      index = lowerText.indexOf(lowerQuery, start);
    }

    // Add remaining text
    if (start < text.length) {
      spans.add(TextSpan(
        text: text.substring(start),
        style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.textPrimary,
        ),
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: widget.isVisible ? 50.h : 8.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceCard,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with toggle button
          GestureDetector(
            onTap: widget.onToggleVisibility,
            child: Container(
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
                    iconName: 'subtitles',
                    color: AppTheme.textPrimary,
                    size: 20,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'Transcript',
                    style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 8.w,
                    height: 0.5.h,
                    decoration: BoxDecoration(
                      color: AppTheme.textTertiary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  CustomIconWidget(
                    iconName: widget.isVisible
                        ? 'keyboard_arrow_down'
                        : 'keyboard_arrow_up',
                    color: AppTheme.textSecondary,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),

          if (widget.isVisible) ...[
            // Search bar
            Padding(
              padding: EdgeInsets.all(4.w),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search transcript...',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'search',
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(3.w),
                            child: CustomIconWidget(
                              iconName: 'clear',
                              color: AppTheme.textSecondary,
                              size: 20,
                            ),
                          ),
                        )
                      : null,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppTheme.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppTheme.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        BorderSide(color: AppTheme.accentCoral, width: 2),
                  ),
                ),
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
            ),

            // Transcript segments
            Expanded(
              child: _filteredSegments.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'search_off',
                            color: AppTheme.textTertiary,
                            size: 48,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            _searchQuery.isEmpty
                                ? 'No transcript available'
                                : 'No results found for "$_searchQuery"',
                            style: AppTheme.darkTheme.textTheme.bodyLarge
                                ?.copyWith(
                              color: AppTheme.textTertiary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      itemCount: _filteredSegments.length,
                      itemBuilder: (context, index) {
                        final segment = _filteredSegments[index];
                        final originalIndex =
                            widget.transcriptSegments.indexOf(segment);
                        final isActive = _activeSegmentIndex == originalIndex;

                        return GestureDetector(
                          onTap: () {
                            final timestamp =
                                _timestampToDuration(segment['timestamp']);
                            widget.onSeekToTimestamp(timestamp);
                            HapticFeedback.lightImpact();
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2.h),
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppTheme.accentCoral.withValues(alpha: 0.1)
                                  : AppTheme.secondaryDark,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isActive
                                    ? AppTheme.accentCoral
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.w,
                                        vertical: 0.5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? AppTheme.accentCoral
                                            : AppTheme.successTeal
                                                .withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        segment['timestamp'],
                                        style: AppTheme
                                            .darkTheme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: isActive
                                              ? AppTheme.textPrimary
                                              : AppTheme.successTeal,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    if (isActive)
                                      CustomIconWidget(
                                        iconName: 'play_circle_filled',
                                        color: AppTheme.accentCoral,
                                        size: 16,
                                      ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                _buildHighlightedText(
                                    segment['text'], _searchQuery),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
