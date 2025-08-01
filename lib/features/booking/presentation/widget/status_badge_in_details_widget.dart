import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/booking_riverpod.dart';

class StatusBadgeInDetailsWidget extends StatelessWidget {
  final String status;

  const StatusBadgeInDetailsWidget({
    super.key,
    required this.status,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AutoSizeTextWidget(
          text: 'حالة الحجز',
          fontSize: 10,
          colorText: Color(0xff605A65),
        ),
        const Spacer(),
        Consumer(
          builder: (context, ref, child) {
            final colors = ref.watch(statusColorsProvider(status));

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
              decoration: BoxDecoration(
                color: colors.background.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12.sp),
                border: Border.all(color: colors.text.withOpacity(0.3)),
              ),
              child: AutoSizeTextWidget(
                text:status=="منتهيه"? 'مكتملة':status,
                fontSize: 10,
                colorText: colors.text,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      ],
    );
  }
}
