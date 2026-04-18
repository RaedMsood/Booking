import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AutoSizeTextWidget extends StatelessWidget {
  static const double _stepGranularity = 0.25;

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? colorText;
  final int? maxLines;
  final double? maxFontSize;
  final double? minFontSize;

  const AutoSizeTextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.colorText,
    this.maxLines,
    this.maxFontSize,
    this.minFontSize,
  });

  @override
  Widget build(BuildContext context) {
    final normalizedMinFontSize = _normalizeFontSize(minFontSize ?? 10);
    final normalizedMaxFontSize = _normalizeFontSize(
      (maxFontSize ?? 24) < normalizedMinFontSize
          ? normalizedMinFontSize
          : (maxFontSize ?? 24),
    );

    return AutoSizeText(
      text,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontSize ?? 14.sp,
        color: colorText ?? Colors.black,
        fontFamily: 'ReadexPro',
        decoration: TextDecoration.none,
      ),
      maxLines: maxLines ?? 1,
      maxFontSize: normalizedMaxFontSize,
      minFontSize: normalizedMinFontSize,
      stepGranularity: _stepGranularity,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,

    );
  }

  double _normalizeFontSize(double value) {
    final steps = (value / _stepGranularity).round();
    return steps * _stepGranularity;
  }
}
