import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class BookingIdBadge extends StatelessWidget {
  final String bookingId;
  final VoidCallback? onCopy;

  const BookingIdBadge({
    Key? key,
    required this.bookingId,
    this.onCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCopy ??
          () {
            Clipboard.setData(ClipboardData(text: bookingId));
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم نسخ رقم الحجز')),
            );
          },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 4.sp),
        decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(16.sp),
            border: Border.all(color: Colors.black.withOpacity(0.1))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.copy, size: 8, color: Colors.black),
            4.horizontalSpace,
            AutoSizeTextWidget(
              text: bookingId,
              fontSize: 8,
              minFontSize: 4,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
