import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';

class StatusBadgeInDetailsWidget extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadgeInDetailsWidget({
    Key? key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AutoSizeTextWidget(
          text: 'حالة الطلب',
          fontSize: 10,
          colorText: Color(0xff605A65),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.sp),
          ),
          child: AutoSizeTextWidget(
            text: label,
            fontSize: 10,
            colorText: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
