import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';

class PolicyTileWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const PolicyTileWidget({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),

            const Icon(Icons.add, size: 20),
          ],
        ),
      ),
    );
  }
}
