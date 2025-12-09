import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/rating_bar_widget.dart';

class RateOfScoreWidget extends StatelessWidget {
  const RateOfScoreWidget({super.key,required this.rateOfScore});
  final dynamic rateOfScore;

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(
          horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color:
        const Color(0xfffef4d4).withValues(alpha:.8),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Row(
        children: [
          AutoSizeTextWidget(
            text: rateOfScore.toStringAsFixed(1),
            fontSize: 10.5.sp,
            colorText: AppColors.secondaryColor,
          ),
          1.8.w.horizontalSpace,
          const RatingBarWidget(
            evaluation: 4,
            length: 1,
          ),
        ],
      ),
    );
  }
}
