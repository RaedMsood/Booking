import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/constants/app_icons.dart';
import '../core/helpers/navigateTo.dart';
import '../core/theme/app_colors.dart';
import '../core/widgets/auto_size_text_widget.dart';
import '../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../services/auth/auth.dart';
import 'user/presentation/pages/splach_screen_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  void nav() async {
    await Future.delayed(const Duration(seconds: 3)).then((value) async {
      var onBoarding = await Auth().getOnBoarding();

      if (onBoarding) {
        navigateAndFinish(context, const BottomNavigationBarWidget());
      } else {
        navigateAndFinish(context, const SplachScreenPage());
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Animation setup
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );

    // Start animation
    _logoController.forward();

    nav();
  }

  @override
  void dispose() {
    _logoController.dispose();
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                   // mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: SvgPicture.asset(
                            AppIcons.logo1,
                            height: 80.h,
                            colorFilter: const ColorFilter.mode(
                              AppColors.whiteColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      4.h.verticalSpace,
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: SvgPicture.asset(
                            AppIcons.logo3,
                            height: 60.h,
                            colorFilter: const ColorFilter.mode(
                              AppColors.whiteColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
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
