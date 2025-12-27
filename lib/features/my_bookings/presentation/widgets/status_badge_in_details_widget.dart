import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';

class StatusBadgeInDetailsWidget extends StatelessWidget {
  final String status;
  final String backgroundColor;
  final String textColor;
  const StatusBadgeInDetailsWidget({
    super.key,
    required this.status,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AutoSizeTextWidget(
          text: S.of(context).bookingStatusLabel,
          fontSize: 9.sp,
          colorText: const Color(0xff605A65),
        ),
        const Spacer(),
        Consumer(
          builder: (context, ref, child) {

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 4.sp),
              decoration: BoxDecoration(
                color:  Color(int.parse(backgroundColor)).withValues(alpha:0.5),
                borderRadius: BorderRadius.circular(12.sp),
                border: Border.all(color:Color(int.parse(textColor)).withValues(alpha:0.3)),
              ),
              child: AutoSizeTextWidget(
                text:status,
                fontSize: 9.sp,
                colorText: Color(int.parse(textColor)),
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      ],
    );
  }
}
