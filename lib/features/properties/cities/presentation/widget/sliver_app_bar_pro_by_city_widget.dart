import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/custom_shape_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import 'city_name_and_flag_widget.dart';

class SliverAppBarProByCityWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String images;
  final String cityName;

  const SliverAppBarProByCityWidget({
    super.key,
    required this.images,
    required this.cityName,
  });

  @override
  Size get preferredSize => Size.fromHeight(46.h);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: AppColors.whiteColor,
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 46.h,
      expandedHeight: 220.h,
      pinned: true,
      leadingWidth: 62.w,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 11.h).copyWith(top: 4.4.h),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const IconButtonWidget(
            icon: AppIcons.arrowBack,
            iconColor: AppColors.mainColorFont,
          ),
        ),
      ),
      flexibleSpace: ClipPath(
        clipper: CustomShapeWidget(),
        clipBehavior: Clip.hardEdge,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final collapsedHeight =
                kToolbarHeight + MediaQuery.of(context).padding.top;
            final isCollapsed = constraints.maxHeight <= collapsedHeight;

            return FlexibleSpaceBar(
              centerTitle: true,
              title: AnimatedOpacity(
                opacity: isCollapsed ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: isCollapsed
                    ? CityNameAndFlagWidget(
                        cityName: cityName,
                        fontSize: 15.sp,
                        flagHeight: 14.2.h,
                      )
                    : const SizedBox.shrink(),
              ),
              background: OnlineImagesWidget(
                imageUrl: images,
                size: Size(double.infinity, 246.h),
                borderRadius: 0,
              ),
            );
          },
        ),
      ),
    );
  }
}
