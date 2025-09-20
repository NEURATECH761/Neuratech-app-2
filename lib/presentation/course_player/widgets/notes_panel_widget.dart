import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NotesPanelWidget extends StatefulWidget {
  final List<Map<String, dynamic>> notes;
  final Duration currentPosition;
  final Function(String, Duration) onAddNote;
  final Function(int) onDeleteNote;
  final Function(Duration) onSeekToTimestamp;

  const NotesPanelWidget({
    Key? key,
    required this.notes,
    required this.currentPosition,
    required this.onAddNote,
    required this.onDeleteNote,
    required this.onSeekToTimestamp,
  }) : super(key: key);

  @override
  State<NotesPanelWidget> createState() => _NotesPanelWidgetState();
}

class _NotesPanelWidgetState extends State<NotesPanelWidget> {
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _noteFocusNode = FocusNode();
  bool _isAddingNote = false;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  void _addNote() {
    if (_noteController.text.trim().isNotEmpty) {
      widget.onAddNote(_noteController.text.trim(), widget.currentPosition);
      _noteController.clear();
      setState(() {
        _isAddingNote = false;
      });
      HapticFeedback.lightImpact();
    }
  }

  void _cancelAddNote() {
    _noteController.clear();
    setState(() {
      _isAddingNote = false;
    });
    _noteFocusNode.unfocus();
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDialog,
        title: Text(
          'Delete Note',
          style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this note?',
          style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              widget.onDeleteNote(index);
              HapticFeedback.lightImpact();
            },
            child: Text(
              'Delete',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.errorSoft,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
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
          // Header
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
                  iconName: 'note_add',
                  color: AppTheme.textPrimary,
                  size: 20,
                ),
                SizedBox(width: 3.w),
                Text(
                  'Notes',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: AppTheme.accentCoral.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${widget.notes.length}',
                    style: AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                      color: AppTheme.accentCoral,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Add note section
          if (_isAddingNote) ...[
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.secondaryDark.withValues(alpha: 0.5),
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.borderColor,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.5.h),
                        decoration: BoxDecoration(
                          color: AppTheme.successTeal.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _formatDuration(widget.currentPosition),
                          style:
                              AppTheme.darkTheme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.successTeal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _cancelAddNote,
                        child: CustomIconWidget(
                          iconName: 'close',
                          color: AppTheme.textSecondary,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  TextField(
                    controller: _noteController,
                    focusNode: _noteFocusNode,
                    autofocus: true,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Add your note here...',
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
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _cancelAddNote,
                          child: Text('Cancel'),
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _addNote,
                          child: Text('Save Note'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ] else ...[
            // Add note button
            Padding(
              padding: EdgeInsets.all(4.w),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isAddingNote = true;
                    });
                  },
                  icon: CustomIconWidget(
                    iconName: 'add',
                    color: AppTheme.textPrimary,
                    size: 20,
                  ),
                  label: Text(
                      'Add Note at ${_formatDuration(widget.currentPosition)}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentCoral,
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                  ),
                ),
              ),
            ),
          ],

          // Notes list
          Expanded(
            child: widget.notes.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'note_add',
                          color: AppTheme.textTertiary,
                          size: 48,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'No notes yet',
                          style: AppTheme.darkTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.textTertiary,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Add notes with timestamps to remember\nimportant moments in the lesson',
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textTertiary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    itemCount: widget.notes.length,
                    itemBuilder: (context, index) {
                      final note = widget.notes[index];
                      final timestamp =
                          Duration(seconds: note['timestamp'] ?? 0);

                      return Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        decoration: BoxDecoration(
                          color: AppTheme.secondaryDark,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppTheme.borderColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Note header
                            Padding(
                              padding: EdgeInsets.fromLTRB(4.w, 3.w, 2.w, 0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      widget.onSeekToTimestamp(timestamp);
                                      HapticFeedback.lightImpact();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.w,
                                        vertical: 0.5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppTheme.successTeal
                                            .withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomIconWidget(
                                            iconName: 'play_arrow',
                                            color: AppTheme.successTeal,
                                            size: 12,
                                          ),
                                          SizedBox(width: 1.w),
                                          Text(
                                            _formatDuration(timestamp),
                                            style: AppTheme
                                                .darkTheme.textTheme.labelSmall
                                                ?.copyWith(
                                              color: AppTheme.successTeal,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    note['createdAt'] ?? 'Just now',
                                    style: AppTheme
                                        .darkTheme.textTheme.labelSmall
                                        ?.copyWith(
                                      color: AppTheme.textTertiary,
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  GestureDetector(
                                    onTap: () => _showDeleteConfirmation(index),
                                    child: Container(
                                      padding: EdgeInsets.all(1.w),
                                      child: CustomIconWidget(
                                        iconName: 'delete_outline',
                                        color: AppTheme.textTertiary,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Note content
                            Padding(
                              padding: EdgeInsets.fromLTRB(4.w, 2.w, 4.w, 3.w),
                              child: Text(
                                note['text'] ?? '',
                                style: AppTheme.darkTheme.textTheme.bodyMedium
                                    ?.copyWith(
                                  color: AppTheme.textPrimary,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    _noteFocusNode.dispose();
    super.dispose();
  }
}
