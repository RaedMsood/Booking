import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../generated/l10n.dart';

class PriceAndCurrencyWidget extends StatelessWidget {
  final String price;
  final Color? firstColor;
  final Color? secondColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? fontSizeSecondText;
  final FontWeight? fontWeightSecondText;

  const PriceAndCurrencyWidget({
    super.key,
    required this.price,
    this.firstColor,
    this.secondColor,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.fontSizeSecondText,
    this.fontWeightSecondText,
  });

  @override
  Widget build(BuildContext context) {
    final NumberFormat formatter = NumberFormat('#,##0', 'en_US');

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: formatter.format(double.tryParse(price.toString())),
            style: TextStyle(
              color: firstColor ?? AppColors.primaryColor,
              fontSize: fontSize ?? 12.sp,
              fontWeight: fontWeight ?? FontWeight.w500,
              fontFamily: 'ReadexPro',
            ),
          ),
          TextSpan(
            text: " ${S.of(context).YER}",
            style: TextStyle(
              color: secondColor ?? const Color(0xff757575),
              fontSize: fontSizeSecondText ?? 11.sp,
              fontWeight: fontWeightSecondText ?? FontWeight.w300,
              fontFamily: 'ReadexPro',
            ),
          ),
        ],
      ),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
