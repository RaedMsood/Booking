import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/booking/presentation/page/booking_page.dart';
import '../../../features/map/presentation/page/map_page.dart';
import '../../../features/profile/presentation/page/profile_page.dart';
import '../../../features/properties/home/presentation/pages/home_page.dart';
import '../../../generated/l10n.dart';
import '../../constants/app_icons.dart';
import '../../helpers/exit_from_the_app.dart';
import '../../theme/app_colors.dart';
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
    ExitFromAppWidget(child: BookingPage()),
    const ExitFromAppWidget(child: MapPage()),
    ExitFromAppWidget(child: BookingPage()),
    const ExitFromAppWidget(child: ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    var activeIndex = ref.watch(activeIndexProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.scaffoldColor,
        systemNavigationBarDividerColor: AppColors.scaffoldColor,
        systemNavigationBarIconBrightness: Brightness.dark,

      ),
      child: Scaffold(
        extendBody: true,
        body: _pages[activeIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.scaffoldColor.withOpacity(.0),
                AppColors.scaffoldColor.withOpacity(.84),
                AppColors.scaffoldColor,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(left: 14.w, right: 14.w, bottom: 14.h),
            padding: EdgeInsets.symmetric(vertical: 11.h),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(38.r),
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
