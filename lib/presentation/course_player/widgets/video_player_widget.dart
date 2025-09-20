import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  final Duration videoDuration;
  final Function(Duration) onProgressChanged;
  final VoidCallback? onVideoCompleted;

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    required this.videoTitle,
    required this.videoDuration,
    required this.onProgressChanged,
    this.onVideoCompleted,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  bool _isPlaying = false;
  bool _showControls = true;
  double _currentPosition = 0.0;
  double _playbackSpeed = 1.0;
  String _selectedQuality = 'Auto';
  bool _isFullscreen = false;
  bool _isPictureInPicture = false;

  final List<double> _playbackSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
  final List<String> _qualityOptions = [
    'Auto',
    '1080p',
    '720p',
    '480p',
    '360p'
  ];

  @override
  void initState() {
    super.initState();
    _hideControlsAfterDelay();
  }

  void _hideControlsAfterDelay() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _hideControlsAfterDelay();
    }

    HapticFeedback.lightImpact();
  }

  void _onProgressChanged(double value) {
    setState(() {
      _currentPosition = value;
    });

    final position = Duration(
      milliseconds: (value * widget.videoDuration.inMilliseconds).round(),
    );
    widget.onProgressChanged(position);
  }

  void _seekForward() {
    final newPosition =
        _currentPosition + (10.0 / widget.videoDuration.inSeconds);
    _onProgressChanged(newPosition.clamp(0.0, 1.0));
    HapticFeedback.selectionClick();
  }

  void _seekBackward() {
    final newPosition =
        _currentPosition - (10.0 / widget.videoDuration.inSeconds);
    _onProgressChanged(newPosition.clamp(0.0, 1.0));
    HapticFeedback.selectionClick();
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });

    if (_isFullscreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  void _togglePictureInPicture() {
    setState(() {
      _isPictureInPicture = !_isPictureInPicture;
    });
    HapticFeedback.lightImpact();
  }

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

  Widget _buildSpeedSelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Playback Speed',
            style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          ...(_playbackSpeeds.map((speed) => GestureDetector(
                onTap: () {
                  setState(() {
                    _playbackSpeed = speed;
                  });
                  HapticFeedback.selectionClick();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  decoration: BoxDecoration(
                    color: _playbackSpeed == speed
                        ? AppTheme.accentCoral.withValues(alpha: 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${speed}x',
                    textAlign: TextAlign.center,
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: _playbackSpeed == speed
                          ? AppTheme.accentCoral
                          : AppTheme.textPrimary,
                      fontWeight: _playbackSpeed == speed
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ))),
        ],
      ),
    );
  }

  Widget _buildQualitySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.darkTheme.colorScheme.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Video Quality',
            style: AppTheme.darkTheme.textTheme.titleSmall?.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: 1.h),
          ...(_qualityOptions.map((quality) => GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedQuality = quality;
                  });
                  HapticFeedback.selectionClick();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  decoration: BoxDecoration(
                    color: _selectedQuality == quality
                        ? AppTheme.accentCoral.withValues(alpha: 0.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    quality,
                    textAlign: TextAlign.center,
                    style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                      color: _selectedQuality == quality
                          ? AppTheme.accentCoral
                          : AppTheme.textPrimary,
                      fontWeight: _selectedQuality == quality
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showControls = !_showControls;
        });
        if (_showControls) {
          _hideControlsAfterDelay();
        }
      },
      onDoubleTapDown: (details) {
        final screenWidth = MediaQuery.of(context).size.width;
        final tapPosition = details.globalPosition.dx;

        if (tapPosition < screenWidth * 0.4) {
          _seekBackward();
        } else if (tapPosition > screenWidth * 0.6) {
          _seekForward();
        }
      },
      child: Container(
        width: double.infinity,
        height: _isFullscreen ? 100.h : 30.h,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: _isFullscreen ? null : BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Video placeholder with thumbnail
            Center(
              child: CustomImageWidget(
                imageUrl:
                    "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Video overlay gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),

            // Controls overlay
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // Top controls
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CustomIconWidget(
                                iconName: 'arrow_back',
                                color: AppTheme.textPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Text(
                              widget.videoTitle,
                              style: AppTheme.darkTheme.textTheme.titleMedium
                                  ?.copyWith(
                                color: AppTheme.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: _togglePictureInPicture,
                            child: Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: CustomIconWidget(
                                iconName: 'picture_in_picture',
                                color: _isPictureInPicture
                                    ? AppTheme.accentCoral
                                    : AppTheme.textPrimary,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Center play/pause button
                    GestureDetector(
                      onTap: _togglePlayPause,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: AppTheme.accentCoral.withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                        ),
                        child: CustomIconWidget(
                          iconName: _isPlaying ? 'pause' : 'play_arrow',
                          color: AppTheme.textPrimary,
                          size: 32,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Bottom controls
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: Column(
                        children: [
                          // Progress bar
                          Row(
                            children: [
                              Text(
                                _formatDuration(Duration(
                                  milliseconds: (_currentPosition *
                                          widget.videoDuration.inMilliseconds)
                                      .round(),
                                )),
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Expanded(
                                child: SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 3,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 8),
                                    overlayShape: const RoundSliderOverlayShape(
                                        overlayRadius: 16),
                                  ),
                                  child: Slider(
                                    value: _currentPosition,
                                    onChanged: _onProgressChanged,
                                    activeColor: AppTheme.accentCoral,
                                    inactiveColor: AppTheme.textTertiary,
                                  ),
                                ),
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                _formatDuration(widget.videoDuration),
                                style: AppTheme.darkTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 1.h),

                          // Control buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: _seekBackward,
                                    child: Container(
                                      padding: EdgeInsets.all(2.w),
                                      child: CustomIconWidget(
                                        iconName: 'replay_10',
                                        color: AppTheme.textPrimary,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  GestureDetector(
                                    onTap: _seekForward,
                                    child: Container(
                                      padding: EdgeInsets.all(2.w),
                                      child: CustomIconWidget(
                                        iconName: 'forward_10',
                                        color: AppTheme.textPrimary,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  PopupMenuButton<double>(
                                    icon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '${_playbackSpeed}x',
                                          style: AppTheme
                                              .darkTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppTheme.textPrimary,
                                          ),
                                        ),
                                        SizedBox(width: 1.w),
                                        CustomIconWidget(
                                          iconName: 'speed',
                                          color: AppTheme.textPrimary,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                    color:
                                        AppTheme.darkTheme.colorScheme.surface,
                                    itemBuilder: (context) => _playbackSpeeds
                                        .map(
                                          (speed) => PopupMenuItem<double>(
                                            value: speed,
                                            child: Text(
                                              '${speed}x',
                                              style: AppTheme.darkTheme
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: _playbackSpeed == speed
                                                    ? AppTheme.accentCoral
                                                    : AppTheme.textPrimary,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onSelected: (speed) {
                                      setState(() {
                                        _playbackSpeed = speed;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 2.w),
                                  PopupMenuButton<String>(
                                    icon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          _selectedQuality,
                                          style: AppTheme
                                              .darkTheme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: AppTheme.textPrimary,
                                          ),
                                        ),
                                        SizedBox(width: 1.w),
                                        CustomIconWidget(
                                          iconName: 'hd',
                                          color: AppTheme.textPrimary,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                    color:
                                        AppTheme.darkTheme.colorScheme.surface,
                                    itemBuilder: (context) => _qualityOptions
                                        .map(
                                          (quality) => PopupMenuItem<String>(
                                            value: quality,
                                            child: Text(
                                              quality,
                                              style: AppTheme.darkTheme
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(
                                                color:
                                                    _selectedQuality == quality
                                                        ? AppTheme.accentCoral
                                                        : AppTheme.textPrimary,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onSelected: (quality) {
                                      setState(() {
                                        _selectedQuality = quality;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 2.w),
                                  GestureDetector(
                                    onTap: _toggleFullscreen,
                                    child: Container(
                                      padding: EdgeInsets.all(2.w),
                                      child: CustomIconWidget(
                                        iconName: _isFullscreen
                                            ? 'fullscreen_exit'
                                            : 'fullscreen',
                                        color: AppTheme.textPrimary,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }
}
