import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class GeneralDesignForBookingWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Widget child;

  const GeneralDesignForBookingWidget({
    super.key,
    required this.title,
    required this.child,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.sp),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: title,
            fontSize: fontSize ?? 11.sp,
          ),
          8.h.verticalSpace,
          child,
        ],
      ),
    );
  }
}
