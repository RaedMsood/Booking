import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import 'details_pictures_widget.dart';

class SliverAppBarDetailsWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isFavorite;
  final bool isLoading;

  final List<String> images;

  const SliverAppBarDetailsWidget({
    super.key,
    this.isFavorite = true,
    this.isLoading = false,
    required this.images,
  });

  @override
  Size get preferredSize => Size.fromHeight(60.h);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.scaffoldColor,
      surfaceTintColor: AppColors.scaffoldColor,
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 56.h,
      expandedHeight: 300.h,
      pinned: true,
      leadingWidth: 65.2.w,
      leading: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.5.h),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20.r,
          child: const IconButtonWidget(
            icon: AppIcons.arrowBack,
            iconColor: AppColors.fontColor,
          ),
        ),
      ),
      actions: isLoading
          ? []
          : [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20.r,
                child: InkWellButtonWidget(
                  icon: AppIcons.sharing,
                  iconColor: AppColors.fontColor,
                  onPressed: () {},
                ),
              ),
              isFavorite ? 8.w.horizontalSpace : const SizedBox.shrink(),
              if (isFavorite)
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20.r,
                  child: IconButtonWidget(
                    icon: AppIcons.favorite,
                    iconColor: AppColors.fontColor,
                    onPressed: () {},
                  ),
                ),
              14.w.horizontalSpace,
            ],
      flexibleSpace: FlexibleSpaceBar(
        background: DetailsPicturesWidget(images: images),
      ),
    );
  }
}
