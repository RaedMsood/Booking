import 'package:booking/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';

class ShimmerPropertyGridCardBody extends StatelessWidget {
  const ShimmerPropertyGridCardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 178.h;
        final imageHeight = (cardHeight * 0.64).clamp(104.h, 122.h).toDouble();
        final contentVerticalPadding = 6.h;
        final contentSpacing = 4.h;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: imageHeight,
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
                        height: 52.h,
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
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  8.w,
                  contentVerticalPadding,
                  8.w,
                  contentVerticalPadding,
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ShimmerPlaceholderWidget(
                              width: 120.w,
                              height: 12.h,
                              borderRadius: 3.r,
                            ),
                          ),
                          6.w.horizontalSpace,
                          ShimmerPlaceholderWidget(
                            height: 16.h,
                            width: 34.w,
                            borderRadius: 40.r,
                          ),
                        ],
                      ),
                      contentSpacing.verticalSpace,
                      const _ShimmerGridLocationRow(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ShimmerGridLocationRow extends StatelessWidget {
  const _ShimmerGridLocationRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerWidget(
          child: SvgPicture.asset(
            AppIcons.location,
            height: 10.5.h,
            colorFilter: const ColorFilter.mode(
              AppColors.fontColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        4.w.horizontalSpace,
        Expanded(
          child: ShimmerPlaceholderWidget(
            width: 76.w,
            height: 9.h,
            borderRadius: 3.r,
          ),
        ),
      ],
    );
  }
}

