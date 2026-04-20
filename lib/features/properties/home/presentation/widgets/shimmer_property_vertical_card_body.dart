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
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = 160.h;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ShimmerPropertyCardMediaSection(imageHeight: imageHeight),
            Expanded(
              child: _ShimmerPropertyCardInfoSection(
                contentVerticalPadding: 4.h,
                contentSpacing: 4.h,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ShimmerPropertyCardMediaSection extends StatelessWidget {
  final double imageHeight;

  const _ShimmerPropertyCardMediaSection({
    required this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}

class _ShimmerPropertyCardInfoSection extends StatelessWidget {
  final double contentVerticalPadding;
  final double contentSpacing;

  const _ShimmerPropertyCardInfoSection({
    required this.contentVerticalPadding,
    required this.contentSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : 48.h;
        final isTight = availableHeight <= 56.h;
        final isVeryTight = availableHeight <= 46.h;
        final verticalPadding = isVeryTight ? 1.5.h : (isTight ? 2.h : contentVerticalPadding);
        final spacing = isVeryTight ? 1.h : (isTight ? 2.h : contentSpacing);

        return Padding(
          padding: EdgeInsetsDirectional.fromSTEB(
            8.w,
            verticalPadding,
            8.w,
            verticalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ShimmerPlaceholderWidget(
                        width: 180.w,
                        height: isVeryTight ? 12.h : 14.h,
                        borderRadius: 3.r,
                      ),
                    ),
                    (isVeryTight ? 4.w : 8.w).horizontalSpace,
                    ShimmerPlaceholderWidget(
                      height: isVeryTight ? 16.h : 18.h,
                      width: isVeryTight ? 34.w : 40.w,
                      borderRadius: 40.r,
                    ),
                  ],
                ),
              ),
              SizedBox(height: spacing),
              Flexible(
                child: const _ShimmerLocationRow(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ShimmerLocationRow extends StatelessWidget {
  const _ShimmerLocationRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ShimmerWidget(
          child: SvgPicture.asset(
            AppIcons.location,
            height: 12.h,
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
            height: 10.h,
            borderRadius: 3.r,
          ),
        ),
      ],
    );
  }
}
