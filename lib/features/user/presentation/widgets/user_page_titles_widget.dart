import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class UserPageTitlesWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const UserPageTitlesWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        AutoSizeTextWidget(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          colorText: const Color(0xff032545),
        ),
        6.h.verticalSpace,
        AutoSizeTextWidget(
          text: subTitle,
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          colorText: AppColors.fontColor,
        ),
      ],
    );
  }
}
