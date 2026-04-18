import 'package:booking/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';

class ShimmerPropertyVerticalCardBody extends StatelessWidget {
  const ShimmerPropertyVerticalCardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160.h,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8.r),
              topLeft: Radius.circular(8.r),
            ),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                const ShimmerPlaceholderWidget(
                  height: double.infinity,
                  borderRadius: 0,
                ),
                Center(
                  child: SvgPicture.asset(
                    AppIcons.logo,
                    height: 70.h,
                    colorFilter: ColorFilter.mode(
                      AppColors.whiteColor.withValues(alpha: 0.7),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.w, 6.h, 8.w, 6.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ShimmerPlaceholderWidget(
                      width: 180.w,
                      height: 14.h,
                      borderRadius: 3.r,
                    ),
                  ),
                  8.w.horizontalSpace,
                  ShimmerPlaceholderWidget(
                    height: 18.h,
                    width: 40.w,
                    borderRadius: 40.r,
                  ),
                ],
              ),
              4.h.verticalSpace,
              _ShimmerLocationRow(
                iconHeight: 12.h,
                placeholderHeight: 10.h,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShimmerLocationRow extends StatelessWidget {
  final double iconHeight;
  final double placeholderHeight;

  const _ShimmerLocationRow({
    required this.iconHeight,
    required this.placeholderHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerWidget(
          child: SvgPicture.asset(
            AppIcons.location,
            height: iconHeight,
            colorFilter: const ColorFilter.mode(
              AppColors.fontColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        4.w.horizontalSpace,
        Expanded(
          child: ShimmerPlaceholderWidget(
            width: 100.w,
            height: placeholderHeight,
            borderRadius: 3.r,
          ),
        ),
      ],
    );
  }
}

