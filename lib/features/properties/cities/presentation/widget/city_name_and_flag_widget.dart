import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_images.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class CityNameAndFlagWidget extends StatelessWidget {
  final String cityName;
  final double? fontSize;
  final Color? colorText;
  final FontWeight? fontWeight;
  final double? flagHeight;

  final double? space;
  final CrossAxisAlignment? crossAxisAlignment;

  const CityNameAndFlagWidget({
    super.key,
    required this.cityName,
    this.fontSize,
    this.colorText,
    this.fontWeight,
    this.flagHeight,
    this.space,
    this.crossAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: AutoSizeTextWidget(
            text: cityName,
            fontWeight: fontWeight ?? FontWeight.w500,
            colorText: colorText ?? Colors.black,
            fontSize: fontSize ?? 13.sp,
            maxLines: 2,
            minFontSize: 13,
          ),
        ),
        space?.w.horizontalSpace ?? 2.w.horizontalSpace,
        Image.asset(
          AppImages.yemen,
          height: flagHeight ?? 13.h,
        ),
      ],
    );
  }
}
