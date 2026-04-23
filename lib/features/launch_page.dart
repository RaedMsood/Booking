import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import '../core/helpers/navigateTo.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/auto_size_text_widget.dart';
import '../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../features/properties/home/presentation/riverpod/home_riverpod.dart';
import '../services/app_update/app_update_service.dart';
import '../services/auth/auth.dart';
import 'user/presentation/pages/splach_screen_page.dart';

class LaunchPage extends ConsumerStatefulWidget {
  const LaunchPage({super.key});

  @override
  ConsumerState<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends ConsumerState<LaunchPage> {
  static const Duration _videoInitTimeout = Duration(seconds: 4);
  static const Duration _onBoardingTimeout = Duration(seconds: 3);
  static const Duration _launchWatchdogTimeout = Duration(seconds: 6);
  static const Duration _homePrefetchDelay = Duration(milliseconds: 250);
  static const List<double> _blackToAlphaWhiteMatrix = <double>[
    0, 0, 0, 0, 255,
    0, 0, 0, 0, 255,
    0, 0, 0, 0, 255,
    0.2126, 0.7152, 0.0722, 0, 0,
  ];

  late final VideoPlayerController _videoController;
  late final Future<bool> _onBoardingFuture;
  Timer? _launchWatchdogTimer;
  bool _isVideoReady = false;
  bool _isNavigationInProgress = false;
  bool _didNavigate = false;
  bool _didScheduleHomePrefetch = false;

  Future<bool> _loadOnBoardingStatus() {
    return Auth()
        .getOnBoarding()
        .timeout(_onBoardingTimeout, onTimeout: () => false);
  }

  void _scheduleHomePrefetch() {
    if (_didScheduleHomePrefetch) return;
    _didScheduleHomePrefetch = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_prefetchHomeData());
    });
  }

  Future<void> _prefetchHomeData() async {
    try {
      await Future<void>.delayed(_homePrefetchDelay);

      if (!mounted || _didNavigate) return;

      final onBoarding = await _onBoardingFuture;

      if (!mounted || _didNavigate || !onBoarding) return;

      ref.read(getAllPropertyProvider.notifier);
    } catch (error) {
      debugPrint('Launch home prefetch skipped: $error');
    }
  }

  Future<void> nav() async {
    if (!mounted || _didNavigate || _isNavigationInProgress) return;

    _isNavigationInProgress = true;

    try {
      final onBoarding = await _onBoardingFuture;

      if (!mounted || _didNavigate) return;

      if (onBoarding) {
        _finishNavigation(const BottomNavigationBarWidget());
      } else {
        _finishNavigation(const SplachScreenPage());
      }
    } finally {
      if (mounted && !_didNavigate) {
        _isNavigationInProgress = false;
      }
    }
  }

  Future<void> _initializeVideo() async {
    try {
      await _videoController.initialize().timeout(_videoInitTimeout);
      await _videoController.setLooping(false);
      await _videoController.setVolume(0);

      _videoController.addListener(_handleVideoState);

      if (!mounted) return;
      setState(() {
        _isVideoReady = true;
      });

      await _videoController.play();
    } catch (error) {
      _handleVideoFailure(error);
    }
  }

  void _handleVideoFailure(Object error) {
    debugPrint('Launch video init failed: $error');
    unawaited(nav());
  }

  void _finishNavigation(Widget page) {
    if (!mounted || _didNavigate) return;
    _didNavigate = true;
    _launchWatchdogTimer?.cancel();
    AppUpdateService.I.markLaunchFlowCompleted();
    navigateAndFinish(context, page);
  }

  void _startLaunchWatchdog() {
    _launchWatchdogTimer?.cancel();
    _launchWatchdogTimer = Timer(_launchWatchdogTimeout, () {
      if (!_isVideoReady) {
        unawaited(nav());
      }
    });
  }

  void _handleVideoState() {
    if (!_videoController.value.isInitialized ||
        _didNavigate ||
        _isNavigationInProgress) {
      return;
    }

    final position = _videoController.value.position;
    final duration = _videoController.value.duration;

    if (duration > Duration.zero && position >= duration) {
      nav();
    }
  }

  @override
  void initState() {
    super.initState();

    AppUpdateService.I.resetLaunchFlow();
    _onBoardingFuture = _loadOnBoardingStatus();
    _videoController = VideoPlayerController.asset('assets/video/mazaji.mp4');
    _scheduleHomePrefetch();
    _startLaunchWatchdog();
    _initializeVideo();
  }

  @override
  void dispose() {
    _launchWatchdogTimer?.cancel();
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
