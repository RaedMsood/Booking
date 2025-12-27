import 'package:booking/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';


class ShimmerPropertyCardWidget extends StatelessWidget {
  final bool propertiesByCity;

  const ShimmerPropertyCardWidget({
    super.key,
    this.propertiesByCity = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: propertiesByCity ? 1 : 0.6,
      shadowColor: propertiesByCity
          ? AppColors.greySwatch.shade50.withValues(alpha:.6)
          : AppColors.greySwatch.shade50.withValues(alpha:.04),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              topLeft: Radius.circular(8.r),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ShimmerPlaceholderWidget(
                  height: 120.h,
                  borderRadius: 0,
                ),
                SvgPicture.asset(
                  AppIcons.logo,
                  height: 70.h,
                  color: AppColors.whiteColor.withValues(alpha: 0.7),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: ShimmerPlaceholderWidget(
                            width: 180.w,
                            height: 18.h,
                            borderRadius: 3.r,
                          ),
                        ),
                        14.w.horizontalSpace,
                        ShimmerPlaceholderWidget(
                          height: 20.h,
                          width: 40.w,
                          borderRadius: 40.r,
                        ),
                      ],
                    ),
                  ),
                  4.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            ShimmerWidget(
                              child: SvgPicture.asset(
                                AppIcons.location,
                                color: AppColors.fontColor,
                                height: 14.h,
                              ),
                            ),
                            4.w.horizontalSpace,
                            Flexible(
                              child: ShimmerPlaceholderWidget(
                                width: 100.w,
                                height: 11.h,
                                borderRadius: 3.r,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
