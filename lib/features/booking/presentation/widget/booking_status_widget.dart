import 'package:booking/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/booking_riverpod.dart';

class StatusBadge extends ConsumerWidget {
  final String status;

  const StatusBadge({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final colors = ref.watch(statusColorsProvider(status));
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
      width: 60.w,
      height: 18.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.background.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.sp),
        border: Border.all(color: colors.text.withOpacity(0.3)),
      ),
      child: AutoSizeTextWidget(
        text: status == "منتهيه" ? 'مكتملة' : status,
        fontSize: 7.5,
        minFontSize: 4,
        colorText: colors.text,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
