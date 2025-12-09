import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../generated/l10n.dart';
import '../riverpod/home_riverpod.dart';

class PropertyViewTypeWidget extends ConsumerWidget {
  const PropertyViewTypeWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var provider = ref.read(getAllPropertyProvider.notifier);
    ref.watch(getAllPropertyProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Directionality.of(context) == TextDirection.rtl
                ? Alignment.centerRight
                : Alignment.centerLeft,
            children: [
              Container(
                height: 8.h,
                width: 88.w,
                margin: EdgeInsets.only(top: 10.h, right: 4.w),
                decoration: BoxDecoration(
                  color: AppColors.primarySwatch.shade300.withValues(alpha:.5),
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),
              AutoSizeTextWidget(
                text: S.of(context).yourHotelDestination,
                fontSize: 13.6.sp,
                colorText: AppColors.mainColorFont,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButtonWidget(
                icon: AppIcons.viewGrid,
                iconColor: provider.viewType == HomePropertyViewType.grid
                    ? AppColors.primaryColor
                    : AppColors.greySwatch.shade400,
                height: 18.h,
                width: 18.w,
                onPressed: () {
                  provider.changeViewType(2);
                },
              ),
              2.w.horizontalSpace,
              InkWellButtonWidget(
                icon: AppIcons.viewList,
                iconColor: provider.viewType == HomePropertyViewType.list
                    ? AppColors.primaryColor
                    : AppColors.greySwatch.shade400,
                height: 18.h,
                width: 18.w,
                onPressed: () {
                  provider.changeViewType(1);
                },
              ),
              2.w.horizontalSpace,
            ],
          ),
        ],
      ),
    );
  }
}
