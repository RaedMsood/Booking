// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../core/constants/app_icons.dart';
// import '../core/helpers/navigateTo.dart';
// import '../core/theme/app_colors.dart';
// import '../core/widgets/auto_size_text_widget.dart';
// import '../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
// import '../services/auth/auth.dart';
// import 'user/presentation/pages/splach_screen_page.dart';
//
// class LaunchPage extends StatefulWidget {
//   const LaunchPage({super.key});
//
//   @override
//   State<LaunchPage> createState() => _LaunchPageState();
// }
//
// class _LaunchPageState extends State<LaunchPage> {
//   void nav() async {
//     await Future.delayed(
//       const Duration(
//         seconds: 3,
//       ),
//     ).then((value) async {
//       var onBoarding = await Auth().getOnBoarding();
//
//       if (onBoarding) {
//         navigateAndFinish(context, const BottomNavigationBarWidget());
//       } else {
//         navigateAndFinish(context, const SplachScreenPage());
//       }
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     nav();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.light,
//           systemNavigationBarColor: AppColors.primarySwatch.shade300,
//           systemNavigationBarDividerColor: AppColors.primarySwatch.shade300,
//           systemNavigationBarIconBrightness: Brightness.light,
//         ),
//         child: Container(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height,
//           padding: EdgeInsets.all(14.sp),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 AppColors.primaryColor,
//                 AppColors.primarySwatch.shade600.withOpacity(.4),
//                 AppColors.primarySwatch.shade400.withOpacity(.4),
//                 AppColors.primarySwatch.shade400,
//                 AppColors.primarySwatch.shade300,
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Spacer(),
//               SvgPicture.asset(
//                 AppIcons.logo,
//                 height: 75.h,
//               ),
//               8.h.verticalSpace,
//               AutoSizeTextWidget(
//                 text: "نُزل",
//                 fontSize: 20.sp,
//                 colorText: AppColors.whiteColor,
//                 fontWeight: FontWeight.w600,
//               ),
//               const Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   AutoSizeTextWidget(
//                     text: "تم التطوير بواسطة",
//                     fontSize: 11.sp,
//                     colorText: AppColors.whiteColor,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   8.w.horizontalSpace,
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       AutoSizeTextWidget(
//                         text: "ألغونِست",
//                         fontSize: 10.6.sp,
//                         colorText: AppColors.whiteColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       AutoSizeTextWidget(
//                         text: "ALGONEST",
//                         fontSize: 10.6.sp,
//                         colorText: AppColors.whiteColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               4.h.verticalSpace,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppColors.primarySwatch.shade300,
          systemNavigationBarDividerColor: AppColors.primarySwatch.shade300,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(14.sp),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.primarySwatch.shade600.withOpacity(.4),
                AppColors.primarySwatch.shade400.withOpacity(.4),
                AppColors.primarySwatch.shade400,
                AppColors.primarySwatch.shade300,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated logo
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: SvgPicture.asset(
                    AppIcons.logo,
                    height: 75.h,
                  ),
                ),
              ),
              8.h.verticalSpace,
              FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: AutoSizeTextWidget(
                    text: "نُزل",
                    fontSize: 18.8.sp,
                    colorText: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeTextWidget(
                    text: "تم التطوير بواسطة",
                    fontSize: 11.sp,
                    colorText: AppColors.whiteColor,
                    fontWeight: FontWeight.w500,
                  ),
                  8.w.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeTextWidget(
                        text: "ألغونِست",
                        fontSize: 10.6.sp,
                        colorText: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                      AutoSizeTextWidget(
                        text: "ALGONEST",
                        fontSize: 10.6.sp,
                        colorText: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
              4.h.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
