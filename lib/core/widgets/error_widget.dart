import 'package:booking/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';

class ErrorWidget extends StatelessWidget {
  final String? image;
  final String title;
  final String subTitle;
  final VoidCallback? onPressed;

  const ErrorWidget({
    super.key,
    this.image,
    required this.title,
    required this.subTitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image ?? AppImages.errorNetwork,
        ),
        12.h.verticalSpace,
        AutoSizeTextWidget(
          text:title,
          fontSize: 11.sp,
          fontWeight: FontWeight.w400,
          colorText: AppColors.fontColor2,
        ),
        6.h.verticalSpace,
        AutoSizeTextWidget(
          text:title,
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          colorText: AppColors.fontColor2,
        ),
      ],
    );
  }
}
