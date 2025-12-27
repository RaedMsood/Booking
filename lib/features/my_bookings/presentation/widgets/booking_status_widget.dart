import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import '../riverpod/my_bookings_riverpod.dart';

class BookingStatusWidget extends ConsumerWidget {
  final String status;
  final String backgroundColor;
  final String textColor;

  const BookingStatusWidget({
    super.key,
    required this.status,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 3.h),
      width: 60.w,
      height: 19.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(int.parse(backgroundColor)).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.sp),
        border:
            Border.all(color: Color(int.parse(textColor)).withValues(alpha: 0.3)),
      ),
      child: AutoSizeTextWidget(
        text: status,
        fontSize: 8.sp,
        minFontSize: 4,
        colorText: Color(int.parse(textColor)),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
