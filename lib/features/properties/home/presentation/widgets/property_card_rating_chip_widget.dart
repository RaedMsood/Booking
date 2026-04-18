import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/rating_bar_widget.dart';

class PropertyCardRatingChipWidget extends StatelessWidget {
  final double rating;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final double itemSize;

  const PropertyCardRatingChipWidget({
    super.key,
    required this.rating,
    required this.fontSize,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.itemSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: const Color(0xfffef4d4).withValues(alpha: .8),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeTextWidget(
            text: rating.toStringAsFixed(1),
            fontSize: fontSize,
            colorText: AppColors.secondaryColor,
          ),
          2.w.horizontalSpace,
          RatingBarWidget(
            evaluation: rating,
            length: 1,
            itemSize: itemSize,
          ),
        ],
      ),
    );
  }
}

