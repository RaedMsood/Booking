import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class LanguageWidget extends StatelessWidget {
  final String language;
  final String value;
  final String languageGroupValue;
  final ValueChanged onChanged;
  final VoidCallback onPressed;

  const LanguageWidget({
    super.key,
    required this.language,
    required this.value,
    required this.languageGroupValue,
    required this.onChanged,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16.sp),
        margin: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: value == languageGroupValue
                ? AppColors.primaryColor
                : AppColors.greySwatch.shade200,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AutoSizeTextWidget(
                text: language.toString(),
                fontSize: 12.sp,
            colorText: value == languageGroupValue
                    ? AppColors.primaryColor
                    : Colors.grey[900],
                maxLines: 2,
              ),
            ),
            8.w.horizontalSpace,
            value == languageGroupValue
                ? SizedBox(
              width: 16.w,
              height: 12.h,
              child: Transform.scale(
                scale: 1,
                child: Radio(
                  value: value,
                  groupValue: languageGroupValue,
                  activeColor: AppColors.primaryColor,
                  onChanged: onChanged,
                  splashRadius: 30,
                ),
              ),
            )
                : CircleAvatar(
              radius: 7.6.r,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                      color: AppColors.primaryColor, width: 0.6.w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
