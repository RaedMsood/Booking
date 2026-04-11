import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../core/helpers/navigateTo.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/auto_size_text_widget.dart';
import '../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../services/app_update/app_update_service.dart';
import '../services/auth/auth.dart';
import 'app_update/presentation/page/force_update_page.dart';
import 'app_update/presentation/widget/optional_update_bottom_sheet.dart';
import 'user/presentation/pages/splach_screen_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  static const List<double> _blackToAlphaWhiteMatrix = <double>[
    0, 0, 0, 0, 255,
    0, 0, 0, 0, 255,
    0, 0, 0, 0, 255,
    0.2126, 0.7152, 0.0722, 0, 0,
  ];

  late final VideoPlayerController _videoController;
  late final Future<AppUpdateInfo> _updateInfoFuture;
  bool _isVideoReady = false;
  bool _didNavigate = false;

  Future<void> nav() async {
    if (!mounted || _didNavigate) return;

    _didNavigate = true;
    final updateInfo = await _updateInfoFuture;

    if (!mounted) return;

    if (updateInfo.requiresUpdate) {
      navigateAndFinish(
        context,
        ForceUpdatePage(updateInfo: updateInfo),
      );
      return;
    }

    if (updateInfo.hasOptionalUpdate) {
      final shouldUpdateNow = await showModalBottomSheet<bool>(
        context: context,
        isDismissible: true,
        enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => OptionalUpdateBottomSheet(updateInfo: updateInfo),
      );

      if (!mounted) return;

      if (shouldUpdateNow != true && updateInfo.latestVersion.isNotEmpty) {
        await Auth().cacheSkippedOptionalUpdateVersion(updateInfo.latestVersion);
      }
    }

    final onBoarding = await Auth().getOnBoarding();

    if (!mounted) return;

    if (onBoarding) {
      navigateAndFinish(context, const BottomNavigationBarWidget());
    } else {
      navigateAndFinish(context, const SplachScreenPage());
    }
  }

  Future<void> _initializeVideo() async {
    try {
      await _videoController.initialize();
      await _videoController.setLooping(false);
      await _videoController.setVolume(0);

      _videoController.addListener(_handleVideoState);

      if (!mounted) return;
      setState(() {
        _isVideoReady = true;
      });

      await _videoController.play();
    } catch (_) {
      await Future.delayed(const Duration(seconds: 3));
      await nav();
    }
  }

  void _handleVideoState() {
    if (!_videoController.value.isInitialized || _didNavigate) return;

    final position = _videoController.value.position;
    final duration = _videoController.value.duration;

    if (duration > Duration.zero && position >= duration) {
      nav();
    }
  }

  @override
  void initState() {
    super.initState();

    _updateInfoFuture = AppUpdateService.I.checkForUpdates();
    _videoController = VideoPlayerController.asset('assets/video/mazaji.mp4');
    _initializeVideo();
  }

  @override
  void dispose() {
    _videoController.removeListener(_handleVideoState);
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarContrastEnforced: false,
        ),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.fromLTRB(
            14.sp,
            MediaQuery.of(context).viewPadding.top + 14.sp,
            14.sp,
            MediaQuery.of(context).viewPadding.bottom + 14.sp,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.primarySwatch.shade600.withValues(alpha: .4),
                AppColors.primarySwatch.shade400.withValues(alpha: .4),
                AppColors.primarySwatch.shade400,
                AppColors.primarySwatch.shade300,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // مساحة مرنة للأعلى، لكن بدون استخدام Spacer بين اللوجوهات.
              Expanded(
                child: Transform.translate(
                  offset: Offset(0, -34.h),
                  child: SizedBox.expand(
                    child: AnimatedOpacity(
                      opacity: _isVideoReady ? 1 : 0,
                      duration: const Duration(milliseconds: 220),
                      child: _isVideoReady
                          ? FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: _videoController.value.size.width,
                                height: _videoController.value.size.height,
                                child: ColorFiltered(
                                  colorFilter: const ColorFilter.matrix(
                                    _blackToAlphaWhiteMatrix,
                                  ),
                                  child: VideoPlayer(_videoController),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),

              // الجزء السفلي مثبت أسفل بدون ما يأثر على مسافة اللوجوهات.
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeTextWidget(
                      text: "تم التطوير بواسطة",
                      fontSize: 11.sp,
                      colorText: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                    8.w.horizontalSpace,
                    AutoSizeTextWidget(
                      text: "ALGONEST",
                      fontSize: 10.6.sp,
                      colorText: AppColors.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
