import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../profile/presentation/state_mangement/riverpod.dart';
import 'details_pictures_widget.dart';

class SliverAppBarDetailsWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isFavorite;
  final bool isLoading;
  final int idProperties;
  final List<String> images;
  final bool isUnit;

  const SliverAppBarDetailsWidget(
      {super.key,
      this.isFavorite = true,
      this.isLoading = false,      this.isUnit = false,


        required this.images,
      required this.idProperties});

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
      actions: isLoading ||isUnit
          ? []
          : [
              // if (isFavorite)
              //   CircleAvatar(
              //     backgroundColor: Colors.white,
              //     radius: 20.r,
              //     child: IconButtonWidget(
              //       icon: AppIcons.favorite,
              //       iconColor: AppColors.fontColor,
              //       onPressed: () {},
              //     ),
              //   ),
              Consumer(
                builder: (context, ref, _) {
                  final isFav = ref.watch(
                    favoriteIdsProvider
                        .select((ids) => ids.contains(idProperties)),
                  );
                  final fav = ref.read(favoriteIdsProvider.notifier);
                  fav.isBusy(idProperties);

                  return CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.r,
                    child: Material(
                      color: Colors.white,
                      shape: const CircleBorder(),
                      child: IconButton(
                        padding: EdgeInsets.all(0.sp),
                        constraints: const BoxConstraints(),
                        onPressed: () => fav.toggle(idProperties),
                        icon: SvgPicture.asset(
                          isFav ? AppIcons.favoriteActive : AppIcons.favorite,
                          color: isFav
                              ? AppColors.primarySwatch.shade400
                              : AppColors.fontColor,
                          height: 18.h,
                        ),
                      ),
                    ),
                  );
                },
              ),
              14.w.horizontalSpace,
            ],
      flexibleSpace: FlexibleSpaceBar(
        background: DetailsPicturesWidget(images: images),
      ),
    );
  }
}
