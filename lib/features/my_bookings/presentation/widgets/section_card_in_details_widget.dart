import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';

class SectionCardInDetailsWidget extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionCardInDetailsWidget({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AutoSizeTextWidget(
            text: title,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
          8.verticalSpace,
          child,
        ],
      ),
    );
  }
}
