import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CameraModalWidget extends StatefulWidget {
  final Function(XFile) onImageSelected;

  const CameraModalWidget({
    Key? key,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<CameraModalWidget> createState() => _CameraModalWidgetState();
}

class _CameraModalWidgetState extends State<CameraModalWidget> {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  bool _isCameraInitialized = false;
  bool _isLoading = false;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<bool> _requestCameraPermission() async {
    if (kIsWeb) return true;
    return (await Permission.camera.request()).isGranted;
  }

  Future<void> _initializeCamera() async {
    try {
      if (!await _requestCameraPermission()) {
        return;
      }

      _cameras = await availableCameras();
      if (_cameras.isEmpty) return;

      final camera = kIsWeb
          ? _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.front,
              orElse: () => _cameras.first)
          : _cameras.firstWhere(
              (c) => c.lensDirection == CameraLensDirection.back,
              orElse: () => _cameras.first);

      _cameraController = CameraController(
        camera,
        kIsWeb ? ResolutionPreset.medium : ResolutionPreset.high,
      );

      await _cameraController!.initialize();
      await _applySettings();

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  Future<void> _applySettings() async {
    if (_cameraController == null) return;

    try {
      await _cameraController!.setFocusMode(FocusMode.auto);
    } catch (e) {
      debugPrint('Focus mode error: $e');
    }

    if (!kIsWeb) {
      try {
        await _cameraController!.setFlashMode(FlashMode.auto);
      } catch (e) {
        debugPrint('Flash mode error: $e');
      }
    }
  }

  Future<void> _capturePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final XFile photo = await _cameraController!.takePicture();
      widget.onImageSelected(photo);
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('Photo capture error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickFromGallery() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        widget.onImageSelected(image);
        Navigator.of(context).pop();
      }
    } catch (e) {
      debugPrint('Gallery picker error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: AppTheme.surfaceDialog,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Update Profile Photo',
                  style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.textSecondary,
                    size: 6.w,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: AppTheme.borderColor, thickness: 1),
          Expanded(
            child: _isCameraInitialized && _cameraController != null
                ? Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: CameraPreview(_cameraController!),
                      ),
                      if (_isLoading)
                        Container(
                          color: Colors.black.withValues(alpha: 0.5),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.accentCoral,
                            ),
                          ),
                        ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'camera_alt',
                          color: AppTheme.textSecondary,
                          size: 15.w,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Camera not available',
                          style:
                              AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Container(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _pickFromGallery,
                    icon: CustomIconWidget(
                      iconName: 'photo_library',
                      color: AppTheme.textPrimary,
                      size: 5.w,
                    ),
                    label: Text('Gallery'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryDark,
                      foregroundColor: AppTheme.textPrimary,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isCameraInitialized && !_isLoading
                        ? _capturePhoto
                        : null,
                    icon: CustomIconWidget(
                      iconName: 'camera_alt',
                      color: AppTheme.textPrimary,
                      size: 5.w,
                    ),
                    label: Text('Camera'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.accentCoral,
                      foregroundColor: AppTheme.textPrimary,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
