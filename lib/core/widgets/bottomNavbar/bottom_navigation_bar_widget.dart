import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/my_bookings/presentation/pages/my_bookings_page.dart';
import '../../../features/map/presentation/page/map_page.dart';
import '../../../features/profile/presentation/page/profile_page.dart';
import '../../../features/properties/home/presentation/pages/home_page.dart';
import '../../../generated/l10n.dart';
import '../../constants/app_icons.dart';
import '../../helpers/exit_from_the_app.dart';
import '../../theme/app_colors.dart';
import '../auto_size_text_widget.dart';
import 'design_for_bottom_navigation_bar_widget.dart';

var activeIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigationBarWidget extends ConsumerStatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  ConsumerState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends ConsumerState<BottomNavigationBarWidget> {
  final List<Widget> _pages = [
    const ExitFromAppWidget(child: HomePage()),
    const ExitFromAppWidget(child: MapPage()),
    const ExitFromAppWidget(child: MyBookingsPage()),
    const ExitFromAppWidget(child: ProfilePage()),
  ];

  /// إظهار رسالة احترافية لتذكير المستخدم بتقييم الفندق باستخدام showGeneralDialog
  // void _showRateHotelDialog() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (!mounted) return;
  //
  //     showGeneralDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       barrierColor: Colors.black54,
  //       barrierLabel: 'rate_hotel',
  //       transitionDuration: const Duration(milliseconds: 220),
  //       pageBuilder: (ctx, animation, secondaryAnimation) {
  //         return const SizedBox.shrink();
  //       },
  //       transitionBuilder: (ctx, animation, secondaryAnimation, child) {
  //         final curved = CurvedAnimation(
  //           parent: animation,
  //           curve: Curves.easeOutBack,
  //           reverseCurve: Curves.easeIn,
  //         );
  //
  //         return Center(
  //           child: AnimatedScale(
  //             scale: curved.value,
  //             duration: Duration.zero,
  //             child: AnimatedOpacity(
  //               opacity: animation.value,
  //               duration: Duration.zero,
  //               child: Container(
  //                 margin: EdgeInsets.symmetric(horizontal: 24.w),
  //                 padding:
  //                     EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(16.r),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.black.withValues(alpha: .08),
  //                       blurRadius: 18,
  //                       offset: const Offset(0, 8),
  //                     ),
  //                   ],
  //                 ),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     AutoSizeTextWidget(
  //                       text:
  //                           'نتمنى أن إقامتك قد كانت مميزة! 🌟\nشارك تقييمك للفندق الآن وساعدنا على تقديم الأفضل.',
  //                       fontSize: 12.5.sp,
  //                       maxLines: 3,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                     8.h.verticalSpace,
  //                     const AutoSizeTextWidget(
  //                       text:
  //                           'تقييمك يساعدنا على تحسين الخدمات وتقديم تجربة أفضل لك ولجميع ضيوفنا.',
  //                       fontSize: 11.5,
  //                       fontWeight: FontWeight.w400,
  //                       maxLines: 4,
  //                       textAlign: TextAlign.center,
  //                     ),
  //                     14.h.verticalSpace,
  //                     Row(
  //                       children: [
  //                         Expanded(
  //                           child: DefaultButtonWidget(
  //                             text: 'قيم الآن',
  //                             textSize: 12.sp,
  //                             height: 35.h,
  //                             onPressed: () {
  //                               Navigator.of(ctx).pop();
  //                             },
  //                           ),
  //                         ),
  //                         10.w.horizontalSpace,
  //
  //                         Expanded(
  //                           child: DefaultButtonWidget(
  //                             text: 'لاحقاً',
  //                              textSize: 12.sp,
  //                             background: Colors.transparent,
  //                             textColor: Colors.black,
  //                             height: 35.h,
  //                             border: Border.all(
  //                               color: AppColors.greySwatch.shade400,
  //                               width: 0.5.w,
  //                             ),
  //                             onPressed: () {
  //                               Navigator.of(ctx).pop();
  //                             },
  //                           ),
  //                         ),
  //
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // عرض رسالة التقييم بعد الدخول إلى الشاشة الرئيسية (بعد صفحة البداية)
   // _showRateHotelDialog();
  }

  @override
  Widget build(BuildContext context) {
    var activeIndex = ref.watch(activeIndexProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            ref.read(activeIndexProvider.notifier).state == 0
                ? Brightness.light
                : Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
      ),
      child: Scaffold(
        body: _pages[activeIndex],
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.greySwatch.shade100,
                  blurRadius: 10,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  AppIcons.home,
                  AppIcons.homeActive,
                  S.of(context).home,
                  0,
                  activeIndex,
                ),
                _buildNavItem(
                  AppIcons.map,
                  AppIcons.mapActive,
                  S.of(context).map,
                  1,
                  activeIndex,
                ),
                _buildNavItem(
                  AppIcons.myReservations,
                  AppIcons.myReservationsActive,
                  S.of(context).myReservations,
                  2,
                  activeIndex,
                ),
                _buildNavItem(
                  AppIcons.profile,
                  AppIcons.profileActive,
                  S.of(context).profile,
                  3,
                  activeIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String activeIcon, String label, int index,
      int activeIndex) {
    return DesignForBottomNavigationBarWidget(
      icon: icon,
      activeIcon: activeIcon,
      label: label,
      active: activeIndex == index,
      onTap: () {
        if (mounted) {
          ref.read(activeIndexProvider.notifier).state = index;
        }
      },
    );
  }
}
