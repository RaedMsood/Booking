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
