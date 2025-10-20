import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final double tbh = 46.h;
    final double topInset = MediaQuery.viewPaddingOf(context).top;

    return SliverAppBar(
      backgroundColor: AppColors.whiteColor,
      surfaceTintColor: AppColors.whiteColor,
      elevation: 0,
      pinned: true,
      toolbarHeight: tbh,
      expandedHeight: 220.h,
      leadingWidth: 62.w,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
      ),
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 11.h).copyWith(top: 4.4.h),
        child: Container(
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const IconButtonWidget(
              icon: AppIcons.arrowBack, iconColor: AppColors.mainColorFont),
        ),
      ),
      flexibleSpace: ClipPath(
        clipper: CustomShapeWidget(),
        clipBehavior: Clip.hardEdge,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool isCollapsed =
                constraints.maxHeight <= (tbh + topInset + 1);

            return FlexibleSpaceBar(
              centerTitle: true,
              title: AnimatedOpacity(
                opacity: isCollapsed ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
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
