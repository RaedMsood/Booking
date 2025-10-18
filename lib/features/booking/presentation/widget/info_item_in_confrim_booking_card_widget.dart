import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';

class InfoItemInConfrimBookingCardWidget extends StatelessWidget {
  final IconData? icon;
  final String text;
  final String title;

  final String? label;
  final VoidCallback? onTap;

  const InfoItemInConfrimBookingCardWidget({
    super.key,
    this.icon,
    required this.text,
    this.label,
    this.onTap,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        AutoSizeTextWidget(
          text: title,
          fontSize: 10,
          colorText: const Color(0xff605A65),
          fontWeight: FontWeight.w500,

        ),
        const Spacer(),
        Icon(icon, size: 12, color: const Color(0xff605A65)),
        2.horizontalSpace,
        AutoSizeTextWidget(
          text: text,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          colorText: const Color(0xff292D32),
        ),
      ],
    );
    return onTap != null ? GestureDetector(onTap: onTap, child: child) : child;
  }
}
