import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../generated/l10n.dart';

class PropertyDetailsTabBarWidget extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  final BuildContext context;

  PropertyDetailsTabBarWidget(this.tabController, this.context);

  late final TabBar _tabBar = TabBar(
    controller: tabController,
    isScrollable: true,
    labelPadding: EdgeInsets.symmetric(horizontal: 30.w),
    physics: const ClampingScrollPhysics(),
    labelStyle: TextStyle(
      fontSize: 11.5.sp,
      fontWeight: FontWeight.w400,
      fontFamily: "ReadexPro",
    ),
    unselectedLabelStyle: TextStyle(
      fontSize: 11.5.sp,
      fontWeight: FontWeight.w400,
      fontFamily: "ReadexPro",
    ),
    tabs: [
      Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(S.of(context).about),
            4.w.horizontalSpace,
            SvgPicture.asset(AppIcons.about),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(S.of(context).sections),
            4.w.horizontalSpace,
            SvgPicture.asset(AppIcons.about),
          ],
        ),
      ),
      Tab(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(S.of(context).comments),
            4.w.horizontalSpace,
            SvgPicture.asset(AppIcons.star),
          ],
        ),
      ),
    ],
  );

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool isPinned = shrinkOffset > 0 || overlapsContent;

    return Container(
      color: isPinned ? AppColors.scaffoldColor : Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant PropertyDetailsTabBarWidget oldDelegate) {
    return tabController != oldDelegate.tabController;
  }
}
