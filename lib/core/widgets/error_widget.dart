import 'package:booking/core/constants/app_images.dart';
import 'package:booking/core/widgets/buttons/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../generated/l10n.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';

class ErrorsWidget extends StatelessWidget {
  final String? image;
  final String title;
  final String? subTitle;

  final VoidCallback? onPressed;

  const ErrorsWidget({
    super.key,
    this.onPressed,
    this.image,
    required this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image ?? AppImages.errorNetwork),
        14.h.verticalSpace,
        AutoSizeTextWidget(
          text: title,
        ),
        4.h.verticalSpace,
        if (subTitle!.isNotEmpty)
          AutoSizeTextWidget(
            text: subTitle.toString(),
            colorText: AppColors.fontColor,
            // fontWeight: FontWeight.bold,
            fontSize: 12.4.sp,
          ),
        20.h.verticalSpace,
        DefaultButtonWidget(
          text: S.of(context).refresh,
          width: 160.w,
          height: 36.h,
          onPressed: onPressed,
        )
      ],
    );
  }
}
