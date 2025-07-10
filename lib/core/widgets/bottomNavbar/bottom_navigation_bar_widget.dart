import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // const ExitFromAppWidget(child: HomePage()),
    // const ExitFromAppWidget(child: CategoryPage()),
    // // const ExitFromAppWidget(child: NewPage()),
    // const ExitFromAppWidget(child: CartPage()),
    // const ExitFromAppWidget(child: ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    var activeIndex = ref.watch(activeIndexProvider);

    return Scaffold(
      body: _pages[activeIndex],
      bottomNavigationBar: Container(
        color: AppColors.whiteColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(AppIcons.home, AppIcons.homeActive,
               " S.of(context).home", 0, activeIndex),
            _buildNavItem(AppIcons.category, AppIcons.categoryActive,
                "S.of(context).category", 1, activeIndex),
            // _buildNavItem(AppIcons.newIcon, AppIcons.newActive,
            //     S.of(context).neww, 2, activeIndex),
            _buildNavItem(AppIcons.cart, AppIcons.cartActive,
                "S.of(context).cart", 2, activeIndex),
            _buildNavItem(AppIcons.profile, AppIcons.profileActive,
                "S.of(context).profile", 3, activeIndex),
          ],
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