import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  const StatusBadge({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
      width: 60.w,
      height: 18.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: AutoSizeTextWidget(
        text: label,
        fontSize: 7.5,
        minFontSize: 4,
        colorText: Color(0xfffF4D4F ),
        fontWeight: FontWeight.w500,

      ),
    );
  }
}
