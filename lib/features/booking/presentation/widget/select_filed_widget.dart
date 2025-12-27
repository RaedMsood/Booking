import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class SelectFieldWidget extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;
  final Color? selectFiledColor;
  final Color? fontColorLabel;
  final double? fontSizeValue;

  final double? fontSizeLabel;

  const SelectFieldWidget(
      {super.key,
      required this.label,
      required this.value,
      required this.onTap,
      this.fontSizeValue,
      this.selectFiledColor,
      this.fontSizeLabel,
      this.fontColorLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AutoSizeTextWidget(
          colorText: fontColorLabel ?? Colors.black,
          text: label,
          fontSize: fontSizeLabel ?? 8.sp,
          fontWeight: FontWeight.w400,
        ),
        6.verticalSpace,
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 43.h,
            padding: EdgeInsets.symmetric(horizontal: 14.sp),
            decoration: BoxDecoration(
              color: selectFiledColor ?? AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeTextWidget(
                      text: value,
                      fontSize: fontSizeValue ?? 8.sp,
                      fontWeight: FontWeight.w400),
                ),
                const Icon(Icons.keyboard_arrow_left, color: Colors.black54),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
