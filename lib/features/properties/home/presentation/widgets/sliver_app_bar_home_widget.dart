import 'package:booking/core/helpers/navigateTo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../core/widgets/custom_shape_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../notifications/presentation/pages/consumer_notifications_page.dart';
import '../../../search_and_filter/presentation/pages/search_and_filter_page.dart';

class SliverAppBarHomeWidget extends SliverPersistentHeaderDelegate {
  SliverAppBarHomeWidget();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipPath(
      clipper: CustomShapeWidget(),
      clipBehavior: Clip.hardEdge,
      child: Container(
        height: 86.h,
        padding: EdgeInsets.only(top: 4.h),
        decoration: const BoxDecoration(color: AppColors.primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                14.w.horizontalSpace,
                SvgPicture.asset(
                  AppIcons.logo,
                ),
                8.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: S.of(context).hostel,
                  fontSize: 16.sp,
                  colorText: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            Row(
              children: [
                InkWellButtonWidget(
                  icon: AppIcons.search,
                  iconColor: Colors.white,
                  height: 19.h,
                  onPressed: () {
                    navigateTo(context, const SearchAndFilterPage());
                  },
                ),
                IconButtonWidget(
                  icon: AppIcons.notification,
                  onPressed: () {
                    navigateTo(context, NotificationsPage());
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 86.h;

  @override
  double get minExtent => kToolbarHeight + 38.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
